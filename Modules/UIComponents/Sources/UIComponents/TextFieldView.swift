//
//  TextFieldView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 1.2.2022.
//

import SwiftUI

public struct TextFieldView<T: SearchSource>: View {
    public init(viewModel: T) {
        self.viewModel = viewModel
    }
    @ObservedObject public var viewModel: T

    public var body: some View {
        TextField("Enter suffix", text: $viewModel.searchText)
            .padding(.horizontal)
            .background(.thinMaterial)
            .cornerRadius(8)
            .frame(height: 30, alignment: .leading)
    }
}
