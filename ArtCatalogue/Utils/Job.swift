//
//  Job.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 9.2.2022.
//

import Foundation

actor Job<T: Equatable> {
    private var action: (() -> T)

    init(_ action: @autoclosure @escaping () -> T) {
        self.action = action
    }

    func performJob() async -> T {
        return self.action()
    }
}
