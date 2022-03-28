//
//  SearchResultWithDebounce.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 13.2.2022.
//
import SwiftUI
import UIComponents

struct SearchResultDebouncedView: View {
    @StateObject var viewModel: SuffixesViewModel

    var body: some View {
        List {
            ForEach(viewModel.debouncedResult.indices, id: \.self) { index in
                SuffixInfoWithTimeView(viewModel: viewModel, index: index)
                    .modifier(ViewColorModifierLight(index: index, totalQty: viewModel.debouncedResult.count))
                    .cornerRadius(4)
            }
        }
    }
}
