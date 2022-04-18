//
//  ArtworkItemView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI
import Networking
import Navigation
import UIComponents

struct ArtworkItemView: View {
    @State var item: ArtworkData
    @EnvironmentObject var routeModel: NavigationContainerViewModel

    var body: some View {
        VStack {
            Text("Artwork title:")
                .fontWeight(.light)
            Text(item.title ?? "")
                .bold()
                .padding()
            Text("Artist")
                .fontWeight(.light)
            Text(item.artistDisplay ?? "")
            Text(item.dateDisplay ?? "")
                .padding()

            Text("Origin")
                .fontWeight(.light)
            Text(item.placeOfOrigin ?? "")
                .padding()

            HStack {
                Spacer()
                Button {
                    routeModel.push(screenView: LazyView(ArtImageScreen(artwork: item)).toAnyView())
                } label: {
                    ButtonLabel(title: "Show Image", isGreen: true)
                }
                Spacer()
                Button {
                    self.routeModel.pop()
                } label: {
                    ButtonLabel(title: "Go Back", isGreen: false)
                }
                Spacer()

            }
        }
    }
}
