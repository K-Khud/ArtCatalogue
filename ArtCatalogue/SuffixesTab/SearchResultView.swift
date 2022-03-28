//
//  SearchResultView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 13.2.2022.
//

import SwiftUI
import UIComponents

struct SearchResultView: View {
    @ObservedObject var viewModel: SuffixesViewModel

    var body: some View {
        List {
            ForEach(viewModel.searchResult, id: \.self) { suffixInfo in
                SuffixInfoView(suffix: suffixInfo.suffix, count: suffixInfo.counter)
            }
        }
    }
}
