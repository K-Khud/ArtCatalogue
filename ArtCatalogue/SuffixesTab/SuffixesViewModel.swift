//
//  SuffixesViewModel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 2.2.2022.
//

import Networking
import SwiftUI
import Combine
import RealmSwift

final class SuffixesViewModel: ObservableObject {
    // инжектинг в переменные инстанса класса

    @Injected var network: NetworkService?
    @Injected var cache: CacheService?

    @Published var artists: [ArtistData] = []
    @Published var isPageLoading: Bool = false

    @Published var searchText: String = ""
    @Published var debouncedText = ""

    @Published var searchResult: [SearchResult] = []

    @Published var allSuffixes: [SearchResult] = []
    @Published var allSuffixesSorted: [SearchResult] = []
    @Published var allSuffixesSelectedTab: Int = 0
    @Published var searchResultsSelectedTab: Int = 1
    @Published var topTen: [SearchResult] = []
    @Published var debouncedResult: [SearchResult] = []

    @ObservedObject var scheduler: JobScheduler = JobScheduler<SearchResult>()

//    private var cacheService = try! CacheService()

    private var suffixStat: [String : Int] = [:]
    private let dateFormatter = DateFormatter()

    var page: Int = 0

    var subscription: Set<AnyCancellable> = []
    var debouncedSubscription: Set<AnyCancellable> = []

    init() {
        loadFromFile()
        $searchText
            .map({ (string) -> String? in
                if string.count < 3 {
                    return nil
                }
                return string
            })
            .compactMap{ $0 }
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { (_) in
            } receiveValue: { [unowned self] searchField in
                self.debouncedText = searchField
                let firstJob = Job(findSuffix(debouncedText))
                scheduler.scheduleJob(firstJob)
            }.store(in: &subscription)

        scheduler.$debouncedResults
            .subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink { sortedResults in
                guard !sortedResults.isEmpty else {
                    return
                }
                self.debouncedResult = sortedResults
                self.saveToFile()
            }
            .store(in: &debouncedSubscription)
   }

    var body: some View {
        Text("")
    }

    func load() {
        
        guard isPageLoading == false else {
            return
        }

        allSuffixes.removeAll()
        suffixStat.removeAll()
        isPageLoading = true
        page += 1

        var lastPageCached = 0

        loadFromCache(&lastPageCached)

        guard artists.isEmpty && lastPageCached < page else {
            self.isPageLoading = false
            self.splitIntoSuffixes()
            return
        }

        DispatchQueue.global(qos: .background).async {
            self.network?.getArtists(page: self.page, completion: { data, error in
                self.artists.append(contentsOf: data?.data ?? [])
                self.isPageLoading = false
                self.splitIntoSuffixes()
                guard let data = data else { return }
                self.addToCache(items: data.data, page: self.page)
            })
        }
    }

    // MARK: - Saving and loading of cached testing results

    private func saveToFile() {
        guard debouncedResult.count > 0 else {
            return
        }
        FileService.save(debouncedResult)
    }

    func loadFromFile() {
        guard debouncedResult.count == 0 else {
            return
        }
        debouncedResult = FileService.load()
    }

    // MARK: - Network Request Caching Methods

    private func loadFromCache(_ lastPageCached: inout Int) {
        artists.removeAll()
        do {
            let items = try cache?.queryObjects(with: ArtistsCache.self)
            items?.forEach { cachedObject in
                let cachedArtists = cachedObject.payload
                cachedArtists.forEach { artistObject in
                    let newElement = ArtistData(managedObject: artistObject)
                    artists.append(newElement)
                }
                lastPageCached = cachedObject.page
                
            }
            print("Success in loading pages frome cache")

        } catch {
            print("Error fetching cache from realm: \(error.localizedDescription)")
        }
    }

    private func addToCache(items: [ArtistData], page: Int) {
        var dataObject: [ArtistDataObject] = []
        items.forEach { artistItem in
            dataObject.append(ArtistDataObject(id: artistItem.id,
                                               title: artistItem.title,
                                               birthDate: artistItem.birthDate ?? 0,
                                               birthPlace: artistItem.birthPlace ?? "",
                                               deathDate: artistItem.deathDate ?? 0,
                                               artworkIds: artistItem.artworkIds))
        }
        let newCache = ArtistsCache(page: page, payload: dataObject)
        cache?.add(newCache)
    }

    func changeOrder(isAscOrder: Bool = true) {
        allSuffixesSorted = allSuffixes.sorted(by: {
            isAscOrder ? $0.suffix > $1.suffix :  $0.suffix < $1.suffix
        })
    }

    func getTopTen() {
        let sorted = allSuffixes.sorted(by: {$0.counter > $1.counter})
        guard sorted.count >= 10 else {return}
        topTen = Array(sorted[..<10])
    }

// MARK: - Private methods
    private func findSuffix(_ suffix: String) -> SearchResult {
        let start = CFAbsoluteTimeGetCurrent()

        searchSuffixes(searchItems: suffix)

        let diff = CFAbsoluteTimeGetCurrent() - start

        return SearchResult(suffix: suffix, count: "n/a", timeEst: diff)
    }

    private func splitIntoSuffixes() {
        var suffixes: [String] = []

        let titles = WrappedSequence(wrapping: artists) { iterator in
            return iterator.next()?.title
        }

        for string in titles {
            let sequence = SuffixSequence(suffix: string)
            for suffix in sequence {
                suffixes.append((String(suffix)))
            }
        }

        suffixes.forEach { suffix in
            if let value = suffixStat[suffix] {
                suffixStat.updateValue(value + 1, forKey: suffix)
            } else {
                suffixStat.updateValue(1, forKey: suffix)
            }
            guard let value = suffixStat[suffix] else {
                return
            }
            allSuffixes.append(SearchResult(suffix: suffix, count: String(value)))
        }
        changeOrder()
        getTopTen()
        saveToUserDefaults(allSuffixes)
    }

    private func searchSuffixes(searchItems: String) {
        let newElement = suffixStat
            .filter{$0.0 == searchText}
            .map{SearchResult(suffix: $0.key, count: String($0.value))}.first

        guard let newElement = newElement else {
            return
        }

        let index = searchResult.firstIndex { pair in
            return pair.suffix == newElement.suffix
        }

        guard let index = index else {
            searchResult.append(newElement)
            return
        }

        searchResult[index].counter = newElement.counter
    }

    private func saveToUserDefaults(_ suffixes: [SearchResult]) {
        let sorted = suffixes
            .sorted(by: {$0.counter > $1.counter})
            .filter({$0.suffix.count > 3})
        guard sorted.count >= 3 else {return}
        let topThree = Array(sorted[..<3]).map({String($0.suffix + "-" + $0.counter)}).compactMap({$0})

        let defaults = UserDefaults.standard
        defaults.set(topThree, forKey: "SavedSuffixes")
        WidgetBridget.shared.topThree = topThree
    }
}
