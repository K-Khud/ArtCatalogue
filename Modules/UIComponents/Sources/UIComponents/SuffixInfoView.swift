//
//  SearchResultView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 3.2.2022.
//

import SwiftUI

public struct SuffixInfoView: View {
    public init(index: Int = -1, totalQty: Int = -1, suffix: String, count: String) {
        self.index = index
        self.totalQty = totalQty
        self.suffix = suffix
        self.count = count
    }
    
    @State public var suffix: String
    @State public var count: String

    public var index: Int = -1
    public var totalQty: Int = -1

    public var body: some View {
        HStack {
            Text(suffix)
            Spacer()
            Text(count)
        }
        .frame(height: 40)
        .modifier(ViewColorModifier(index: index, totalQty: totalQty))
    }
}
