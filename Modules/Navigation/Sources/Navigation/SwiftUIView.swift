//
//  SwiftUIView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI

public extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
