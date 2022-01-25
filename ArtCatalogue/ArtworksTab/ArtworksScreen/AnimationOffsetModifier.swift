//
//  AnimationOffsetModifier.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 25.1.2022.
//

import Foundation
import SwiftUI

struct AnimatingOffsetModifier: AnimatableModifier {
    var currentOffsetX: Double = 0
    var currentOffsetY: Double = 0

    var animatableX: Double {
        get { currentOffsetX }
        set { currentOffsetX = newValue }
    }
    var animatableY: Double {
        get { currentOffsetY }
        set { currentOffsetY = newValue }
    }

    func body(content: Content) -> some View {
        content.offset(x: currentOffsetX, y: currentOffsetY)
    }
}
