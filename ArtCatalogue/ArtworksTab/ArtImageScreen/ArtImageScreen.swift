//
//  ArtImageScreen.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import Foundation
import SwiftUI
import Networking
import Navigation

struct ArtImageScreen: View {
    @State var artwork: ArtworkData

    @EnvironmentObject var routeModel: NavigationContainerViewModel
    @StateObject var itemViewModel: ArtImageViewModel = .init()

    var body: some View {
        VStack {
            Text("Artwork title:")
                .fontWeight(.light)
            Text(artwork.title)
                .bold()
                .padding()
            Image(uiImage: itemViewModel.artImage)
                .padding()

            HStack {
//                Spacer()
                LoadButton(viewModel: itemViewModel, artwork: artwork, buttonTitle: "Load Image")
//                Spacer()
                Button {
                    self.routeModel.pop()
                } label: {
                    ButtonLabel(title: "Go Back", isGreen: false)
                }
                .padding()
            }
        }
    }
}
