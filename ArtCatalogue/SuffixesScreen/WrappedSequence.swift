//
//  WrappedSequence.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 2.2.2022.
//

import Foundation

struct WrappedSequence<Wrapped: Sequence, Element>: Sequence {
    typealias IteratorFunction = (inout Wrapped.Iterator) -> Element?

    private let wrapped: Wrapped
    private let iterator: IteratorFunction

    init(wrapping wrapped: Wrapped,
         iterator: @escaping IteratorFunction) {
        self.wrapped = wrapped
        self.iterator = iterator
    }

    func makeIterator() -> AnyIterator<Element> {
        var wrappedIterator = wrapped.makeIterator()
        return AnyIterator { self.iterator(&wrappedIterator) }
    }
}
