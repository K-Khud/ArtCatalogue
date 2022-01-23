//
//  LoadArtistsButton.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 23.1.2022.
//

import SwiftUI
import Networking

struct LoadArtistsButton: View {
    @ObservedObject var viewModel: ArtistsViewModel
    @State var buttonTapped = false

    var buttonTitle: String

    var body: some View {
        HStack {
            Button {
                viewModel.load()
                buttonTapped.toggle()

            } label: {
                Text(buttonTitle)
                    .padding()
                    .background(buttonTapped ? .gray : .green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .frame(alignment: .center)
            }
            .padding(.horizontal)
        }
    }
}

struct LoadArtistsButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadArtistsButton(viewModel: ArtistsViewModel(), buttonTitle: "Load")
    }
}
