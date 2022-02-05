//
//  SearchResultView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 3.2.2022.
//

import SwiftUI

struct SearchResultView: View {
    @State var suffix: String
    @State var count: String
    var body: some View {
        HStack {
            Text(suffix)
            Spacer()
            Text(count)
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(suffix: "suffix", count: "1")
    }
}
