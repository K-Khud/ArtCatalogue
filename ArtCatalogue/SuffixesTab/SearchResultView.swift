//
//  SearchResultView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 13.2.2022.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var viewModel: SuffixesViewModel
    @State var suffixes: [SearchResult] = []

    var body: some View {
        List {
            ForEach(suffixes, id: \.self) { suffixInfo in
                SuffixInfoView(suffix: suffixInfo.suffix, count: suffixInfo.counter)
            }.onReceive(viewModel.$searchResult) { searchResult in
                suffixes = searchResult
            }
        }
    }
}
