//
//  AnimatingCellModifier.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 25.1.2022.
//

import SwiftUI

struct AnimatingCellModifier: AnimatableModifier {
    var cellOpacity: Double = 1
    var animatableData: Double {
        get { cellOpacity }
        set { cellOpacity = newValue }
    }

    func body(content: Content) -> some View {
        content.opacity(cellOpacity)
    }
}
