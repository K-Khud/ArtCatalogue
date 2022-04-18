//
//  LazyView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    public let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    public var body: some View {
        build()
    }
}
