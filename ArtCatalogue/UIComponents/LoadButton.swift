//
//  LoadButton.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 22.1.2022.
//

import SwiftUI

struct LoadButton<T: Loader>: View {
    @ObservedObject var viewModel: T
    var artwork: Codable?
    var buttonTitle: String
    @State var buttonTapped = false

    var body: some View {
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

struct LoadButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadButton(viewModel: ArtworksViewModel(), buttonTitle: "Title")
    }
}
