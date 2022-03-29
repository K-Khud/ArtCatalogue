//
//  Mocks.swift
//  SpaceFlightNewsTests
//
//  Created by Ekaterina Khudzhamkulova on 22.3.2021.
//

import UIKit
@testable import Networking
@testable import ArtCatalogue

class Mocks {
    var artists = [
        ArtistData(id: 0, title: "Mark Shagal", artworkIds: [0]),
        ArtistData(id: 1, title: "Gustav Klimt", artworkIds: [0, 1]),
        ArtistData(id: 2, title: "Hieronymus Bosch", artworkIds: [0, 1, 2])
    ]
    var words = [
        ArtistData(id: 0, title: "Aa", artworkIds: [0]),
        ArtistData(id: 1, title: "Bb", artworkIds: [0, 1]),
        ArtistData(id: 2, title: "Ccc", artworkIds: [0, 1, 2])
    ]

    let suffTarget = [SearchResult(suffix: "", count: "", timeEst: 0.0),
                      SearchResult(suffix: "Aa", count: "", timeEst: 0.0),
                      SearchResult(suffix: "a", count: "", timeEst: 0.0),
                      SearchResult(suffix: "Bb", count: "", timeEst: 0.0),
                      SearchResult(suffix: "b", count: "", timeEst: 0.0),
                      SearchResult(suffix: "Ccc", count: "", timeEst: 0.0),
                      SearchResult(suffix: "cc", count: "", timeEst: 0.0),
                      SearchResult(suffix: "c", count: "", timeEst: 0.0),
                      SearchResult(suffix: "Aa", count: "3", timeEst: 0.0),
                      SearchResult(suffix: "a", count: "2", timeEst: 0.0),
                      SearchResult(suffix: "Bb", count: "7", timeEst: 0.0),
                      SearchResult(suffix: "b", count: "6", timeEst: 0.0),
                      SearchResult(suffix: "Ccc", count: "4", timeEst: 0.0),
                      SearchResult(suffix: "cc", count: "1", timeEst: 0.0),
                      SearchResult(suffix: "c", count: "1", timeEst: 0.0)]

    var suffixStat = ["Aa": 2,
                      "a": 1,
                      "Bb": 6,
                      "b": 5,
                      "Ccc": 3,
                      "Cc": 0]

    var allSuffixes = [SearchResult(suffix: "", count: "", timeEst: 0.0),
                       SearchResult(suffix: "Aa", count: "", timeEst: 0.0),
                       SearchResult(suffix: "a", count: "", timeEst: 0.0),
                       SearchResult(suffix: "Bb", count: "", timeEst: 0.0),
                       SearchResult(suffix: "b", count: "", timeEst: 0.0),
                       SearchResult(suffix: "Ccc", count: "", timeEst: 0.0),
                       SearchResult(suffix: "cc", count: "", timeEst: 0.0),
                       SearchResult(suffix: "c", count: "", timeEst: 0.0)]

    var allSuffixesSorted = [SearchResult(suffix: "", count: "")]
    var topTen = [SearchResult(suffix: "", count: "")]
    var searchResult = [SearchResult(suffix: "", count: "")]
}
