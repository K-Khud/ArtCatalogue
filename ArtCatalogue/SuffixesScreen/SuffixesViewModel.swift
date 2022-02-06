//
//  SuffixesViewModel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 2.2.2022.
//

import Networking
import SwiftUI
import Combine

final class SuffixesViewModel: ObservableObject {
    @Published var artists: [ArtistData] = []
    @Published var isPageLoading: Bool = false
    @Published var searchText: String = ""
    @Published var searchResult: [SearchResult] = []
    @Published var allSuffixes: [SearchResult] = []
    @Published var allSuffixesSorted: [SearchResult] = []
    @Published var selectedPickerTab: Int = 0
    @Published var topTen: [SearchResult] = []

    private var suffixStat: [String : Int] = [:]

    var page: Int = 0

    var subscription: Set<AnyCancellable> = []

    init() {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .map({ (string) -> String? in
                if string.count < 3 {
                    return nil
                }
                return string
            })
            .compactMap{ $0 }
            .sink { (_) in
            } receiveValue: { [self] (searchField) in
                searchSuffixes(searchItems: searchField)
            }.store(in: &subscription)
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

        DispatchQueue.global(qos: .background).async {
            ArtEndpointsAPI.getArtists(page: self.page, completion: { data, error in
                self.artists.append(contentsOf: data?.data ?? [])
                self.isPageLoading = false
                self.splitIntoSuffixes()
            })
        }
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
