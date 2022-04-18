//
//  SuffixIterator.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 2.2.2022.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    let string: String
    let end: String.Index
    let stopIndex: String.Index
    var offset: String.Index

    init(string: String) {
        self.string = string
        self.end = string.endIndex
        self.offset = string.startIndex
        self.stopIndex = string.endIndex
    }

    mutating func next() -> Substring? {
        guard offset < stopIndex else { return nil }

        let sub: Substring = string[offset..<end]
        string.formIndex(after: &offset)
        return sub
    }
}
