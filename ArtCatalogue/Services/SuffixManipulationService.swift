//
//  SuffixManipulationService.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 29.3.2022.
//

import Foundation
import Networking

final class SuffixManipulationService {
// MARK: - Split into suffixes
    func splitIntoSuffixes(artists: inout [ArtistData],
                           suffixStat: inout [String : Int],
                           allSuffixes: inout [SearchResult],
                           allSuffixesSorted: inout [SearchResult],
                           _ topTen: inout [SearchResult]) {
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
        changeOrder(&allSuffixesSorted, allSuffixes)
        getTopTen(allSuffixes, &topTen)
    }

    func changeOrder(isAscOrder: Bool = true, _ allSuffixesSorted: inout [SearchResult], _ allSuffixes: [SearchResult]) {
        allSuffixesSorted = allSuffixes.sorted(by: {
            isAscOrder ? $0.suffix > $1.suffix :  $0.suffix < $1.suffix
        })
    }

    private func getTopTen(_ allSuffixes: [SearchResult], _ topTen: inout [SearchResult]) {
        let sorted = allSuffixes.sorted(by: {$0.counter > $1.counter})
        guard sorted.count >= 10 else {return}
        topTen = Array(sorted[..<10])
    }

// MARK: - Search suffix
    func findSuffix(_ suffixStat: [String : Int], _ suffix: String, searchResult: inout [SearchResult]) -> SearchResult {
        let start = CFAbsoluteTimeGetCurrent()

        searchSuffixes(suffixStat, searchText: suffix, &searchResult)

        let diff = CFAbsoluteTimeGetCurrent() - start

        return SearchResult(suffix: suffix, count: "n/a", timeEst: diff)
    }

    private func searchSuffixes(_ suffixStat: [String : Int], searchText: String, _ searchResult: inout [SearchResult]) {
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
}
