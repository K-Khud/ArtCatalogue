//
//  SearchResult.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 3.2.2022.
//

import Foundation

struct SearchResult: Equatable, Hashable {
    let suffix: String
    var counter: String

    internal init(suffix: String, count: String) {
        self.suffix = suffix
        self.counter = count
    }

    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.suffix == rhs.suffix && lhs.counter == rhs.counter
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(suffix + counter)
    }
}
