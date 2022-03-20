//
//  SearchResultView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 3.2.2022.
//

import SwiftUI

public struct SuffixInfoView: View {
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
        .modifier(ViewColorModifier(index: index, totalQty: totalQty))
    }
}

public struct SearchResultView_Previews: PreviewProvider {
    public static var previews: some View {
        SuffixInfoView(suffix: "suffix", count: "1")
    }
}
