//
//  LoadButton.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 22.1.2022.
//

import SwiftUI

public struct LoadButton<T: Loader>: View {
    public init(viewModel: T, artwork: Codable? = nil, buttonTitle: String) {
        self.viewModel = viewModel
        self.artwork = artwork
        self.buttonTitle = buttonTitle
    }

    @ObservedObject public var viewModel: T
    @State public var buttonTapped = false
    public var artwork: Codable?
    public var buttonTitle: String

    public var body: some View {
        HStack {
            Button {
                viewModel.load(artwork)
                buttonTapped.toggle()

            } label: {
                Text(buttonTitle)
                    .padding()
                    .background(buttonTapped ? Colors.fuchsia : Colors.blueGreen)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .frame(alignment: .center)
            }
            .padding(.horizontal)
        }
    }
}
