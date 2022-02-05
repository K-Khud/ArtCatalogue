//
//  TextFieldView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 1.2.2022.
//

import SwiftUI

struct TextFieldView: View {
    @ObservedObject var viewModel: SuffixesViewModel

    var body: some View {
        TextField("Enter suffix", text: $viewModel.searchText)
            .padding(.horizontal)
            .background(.thinMaterial)
            .cornerRadius(8)
            .frame(height: 30, alignment: .leading)
    }
}
