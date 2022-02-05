//
//  LoadSuffixesButton.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 2.2.2022.
//

import SwiftUI

struct LoadSuffixesButton: View {
    @ObservedObject var viewModel: SuffixesViewModel
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

struct LoadSuffixesButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadSuffixesButton(viewModel: SuffixesViewModel(), buttonTitle: "Load smth with suffixes")
    }
}
