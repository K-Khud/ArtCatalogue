//
//  SuffixSequence.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 18.4.2022.
//

import Foundation

struct SuffixSequence: Sequence {
    let suffix: String

    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: suffix)
    }
}
