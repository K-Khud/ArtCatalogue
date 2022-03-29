//
//  SuffixSplittingService.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 29.3.2022.
//

import Foundation
import Networking

final class SuffixSplittingService {

    func splitIntoSuffixes(artists: inout [ArtistData], suffixStat: inout [String : Int], allSuffixes: inout [SearchResult], allSuffixesSorted: inout [SearchResult], _ topTen: inout [SearchResult]) {
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


}
