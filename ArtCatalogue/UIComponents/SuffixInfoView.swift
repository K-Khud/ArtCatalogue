//
//  SearchResultView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 3.2.2022.
//

import SwiftUI

struct SuffixInfoView: View {
    @State var suffix: String
    @State var count: String

    var index: Int = -1
    var totalQty: Int = -1

    var body: some View {
        
        HStack {
            Text(suffix)
            Spacer()
            Text(count)
        }
        .modifier(ViewColorModifier(index: index, totalQty: totalQty))
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SuffixInfoView(suffix: "suffix", count: "1")
    }
}
