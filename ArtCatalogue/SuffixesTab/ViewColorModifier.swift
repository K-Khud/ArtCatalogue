//
//  ViewColorModifier.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 13.2.2022.
//

import SwiftUI

struct ViewColorModifier: ViewModifier {
    var index: Int
    var totalQty: Int

    @ViewBuilder
    func body(content: Content) -> some View {
        if index == -1 {
            content
        } else if totalQty == 1 {
            let uicolor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            let color = Color(uiColor: uicolor)

            content.background(color)
        } else {
            let share: CGFloat = CGFloat(Double(index) / Double(totalQty - 1))

            let uicolor = UIColor(red: share, green: 1 - share, blue: 0, alpha: 1)
            let color = Color(uiColor: uicolor)

            content.background(color)
        }
    }
}
