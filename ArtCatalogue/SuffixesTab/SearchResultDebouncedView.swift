//
//  SearchResultWithDebounce.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 13.2.2022.
//
import SwiftUI
import UIComponents

struct SearchResultDebouncedView: View {
    @ObservedObject var viewModel: SuffixesViewModel

    var body: some View {
        List {
            ForEach(viewModel.debouncedResult.indices, id: \.self) { index in
                let searchResult = viewModel.debouncedResult[index]
                let totalQty = viewModel.debouncedResult.count
                SuffixInfoView(suffix: searchResult.suffix,
                                 count: String(searchResult.timeEst), index: index, totalQty: totalQty)
            }
        }
    }
}
