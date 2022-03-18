//
//  NavigationStack.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import Foundation

public struct NavigationStack {
    private var screens = [Screen]()

    public mutating func push(_ s: Screen) {
        self.screens.append(s)
    }

    public mutating func pop() {
        _ = self.screens.popLast()
    }

    public mutating func popToRoot() {
        self.screens.removeAll()
    }

    public func top() -> Screen? {
        return self.screens.last
    }
}
