//
//  ArtImageScreen.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI
import Networking
import Navigation
import UIComponents

struct ArtImageScreen: View {
    @State var artwork: ArtworkData

    @EnvironmentObject var routeModel: NavigationContainerViewModel
    @StateObject var itemViewModel: ArtImageViewModel = .init()

    var body: some View {
        VStack {
            Text("Artwork title:")
                .fontWeight(.light)
            Text(artwork.title ?? "")
                .bold()
                .padding()
            if itemViewModel.imageIsLoaded {
                Image(uiImage: itemViewModel.artImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
            }
            HStack {
                LoadButton(viewModel: itemViewModel, artwork: artwork, buttonTitle: "Load Image")
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
