//
//  SuffixesManipulationTests.swift
//  ArtCatalogueTests
//
//  Created by Ekaterina Khudzhamkulova on 29.3.2022.
//

import XCTest
@testable import ArtCatalogue

class SuffixesManipulationTests: XCTestCase {
    let service = SuffixManipulationService()
    let mocks = Mocks()

    func testSplitIntoSuffixes() throws {
        service.splitIntoSuffixes(artists: mocks.words,
                                  suffixStat: &mocks.suffixStat,
                                  allSuffixes: &mocks.allSuffixes,
                                  allSuffixesSorted: &mocks.allSuffixesSorted,
                                  &mocks.topTen)
        XCTAssertEqual(mocks.allSuffixes, mocks.suffTarget)
    }

    func testChangeOrder() throws {
        service.changeOrder(isAscOrder: true,
                            &mocks.allSuffixesSorted,
                            mocks.allSuffixes)
        var allSorted = true
        mocks.allSuffixesSorted.enumerated().forEach { item in
            guard item.offset < mocks.allSuffixesSorted.count - 1 else {return}
            if !(mocks.allSuffixesSorted[item.offset].suffix >= mocks.allSuffixesSorted[item.offset + 1].suffix) {
                allSorted = false
            }
        }
        XCTAssert(allSorted)
    }

    func testSearchSuffixes() throws {
        let output = service.findSuffix(mocks.suffixStat,
                           "cc",
                           searchResult: &mocks.searchResult)
        let target = SearchResult(suffix: "cc", count: "n/a", timeEst: 0.0)

        XCTAssertEqual(target, output)
    }

}
