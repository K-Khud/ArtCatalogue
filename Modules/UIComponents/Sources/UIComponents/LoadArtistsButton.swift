//
//  LoadArtistsButton.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 23.1.2022.
//

import SwiftUI

public struct LoadArtistsButton<T: Loader>: View {
    public init(buttonTitle: String, viewModel: T) {
        self.buttonTitle = buttonTitle
        self.viewModel = viewModel
    }

    @ObservedObject public var viewModel: T
    @State public var buttonTapped = false

    public var buttonTitle: String

    public var body: some View {
        HStack {
            Button {
                viewModel.load(nil)
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
