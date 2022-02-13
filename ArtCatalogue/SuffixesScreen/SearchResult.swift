//
//  SearchResult.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 3.2.2022.
//

import Foundation

struct SearchResult: Equatable, Hashable, Comparable {

    let suffix: String
    var counter: String
    var timeEst: Double = 0

    internal init(suffix: String, count: String, timeEst: Double = 0) {
        self.suffix = suffix
        self.counter = count
        self.timeEst = timeEst
    }

    static func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.timeEst < rhs.timeEst
    }

    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.suffix == rhs.suffix && lhs.counter == rhs.counter
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(suffix + counter)
    }
}
