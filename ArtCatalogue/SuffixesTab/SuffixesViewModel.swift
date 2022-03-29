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
import UIComponents

final class SuffixesViewModel: ObservableObject, Loader, SearchSource {

    @Injected var network: NetworkService?
    @Injected var cache: CacheService?
    @Injected var fileService: FileService?
    @Injected var suffixService: SuffixManipulationService?

    @Published var isPageLoading: Bool = false
    @Published var searchText: String = ""

    @Published var allSuffixes: [SearchResult] = []
    @Published var allSuffixesSorted: [SearchResult] = []
    @Published var topTen: [SearchResult] = []
    @Published var debouncedResult: [SearchResult] = []

    @Published var allSuffixesSelectedTab: Int = 0
    @Published var searchResultsSelectedTab: Int = 1

    @ObservedObject var scheduler: JobScheduler = JobScheduler<SearchResult>()

    private var artists: [ArtistData] = []
    private var suffixStat: [String : Int] = [:]
    private let dateFormatter = DateFormatter()
    private var debouncedText = ""
    private var page: Int = 0

    var searchResult: [SearchResult] = []

    private var subscription: Set<AnyCancellable> = []
    private var debouncedSubscription: Set<AnyCancellable> = []

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
            .sink(receiveValue: { [unowned self] output in
                self.debouncedText = output
                if let strongServise = suffixService {
                    let firstJob = Job(strongServise.findSuffix(self.suffixStat,
                                                   self.debouncedText,
                                                   searchResult: &self.searchResult))
                    scheduler.scheduleJob(firstJob)
                }
            }).store(in: &subscription)

        scheduler
            .$debouncedResults
            .subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { sortedResults in
                guard !sortedResults.isEmpty else {
                    return
                }
                self.debouncedResult = sortedResults
                self.saveToFile()
            }).store(in: &debouncedSubscription)
   }

    var body: some View {
        Text("")
    }

    func load(_ data: Codable? = nil) {

        guard isPageLoading == false else {
            return
        }
// uncomment this if the suffixes new suffixes needed
//        allSuffixes.removeAll()
//        suffixStat.removeAll()
        isPageLoading = true
        page += 1

        var lastPageCached = 0

        loadFromCache(&lastPageCached)

        guard artists.isEmpty && lastPageCached < page else {
            self.isPageLoading = false
            self.suffixService?.splitIntoSuffixes(artists: &artists, suffixStat: &suffixStat, allSuffixes: &allSuffixes, allSuffixesSorted: &allSuffixesSorted, &topTen)
            saveToUserDefaults(allSuffixes)

            return
        }

        DispatchQueue.global(qos: .background).async {
            self.network?.getArtists(page: self.page, completion: { [unowned self] data, error in
                artists.append(contentsOf: data?.data ?? [])
                isPageLoading = false
                suffixService?.splitIntoSuffixes(artists: &artists,
                                                      suffixStat: &suffixStat,
                                                      allSuffixes: &allSuffixes,
                                                      allSuffixesSorted: &allSuffixesSorted,
                                                      &topTen)
                saveToUserDefaults(allSuffixes)

                guard let data = data else { return }
                addToCache(items: data.data, page: self.page)
            })
        }
    }

    func changeOrder(isAscOrder: Bool = true) {
        suffixService?.changeOrder(isAscOrder: isAscOrder,
                                   &allSuffixesSorted,
                                   allSuffixes)
    }

    // MARK: - Saving and loading of cached testing results

    private func saveToFile() {
        guard debouncedResult.count > 0 else {
            return
        }
        fileService?.save(debouncedResult)
    }

    func loadFromFile() {
        guard debouncedResult.count == 0 else {
            return
        }
        debouncedResult = fileService?.load() ?? [SearchResult]()
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

// MARK: - Private methods
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
