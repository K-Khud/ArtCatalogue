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
//    let minLength: Int = 3

    init(string: String) {
        self.string = string
        self.end = string.endIndex
        self.offset = string.startIndex
        self.stopIndex = string.endIndex//.index(end, offsetBy: -minLength + 1)
    }

    mutating func next() -> Substring? {
        guard offset < stopIndex else { return nil }

        let sub: Substring = string[offset..<end]
        string.formIndex(after: &offset)
        return sub
    }
}

struct SuffixSequence: Sequence {
    let suffix: String

    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: suffix)
    }
}
