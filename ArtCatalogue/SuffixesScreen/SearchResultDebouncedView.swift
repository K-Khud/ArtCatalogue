//
//  SearchResultWithDebounce.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 13.2.2022.
//
import Foundation
import SwiftUI

struct SearchResultDebouncedView: View {
    @ObservedObject var viewModel: SuffixesViewModel
    @State var suffixes: [SearchResult] = []

    var body: some View {
        List {

            ForEach(suffixes.indices, id: \.self) { index in
                let searchResult = suffixes[index]
                let totalQty = suffixes.count
                SuffixInfoView(suffix: searchResult.suffix,
                                 count: String(searchResult.timeEst), index: index, totalQty: totalQty)

            }.onReceive(viewModel.scheduler.$sortedResults) { sortedResults in
                suffixes = sortedResults
            }
        }
    }
}
