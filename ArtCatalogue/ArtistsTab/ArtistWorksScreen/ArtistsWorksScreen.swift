//
//  ArtistsWorksScreen.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 23.1.2022.
//

import SwiftUI
import Networking
import Navigation
import UIComponents

struct ArtistsWorksScreen: View {
    @State var artist: ArtistData

    @EnvironmentObject var routeModel: NavigationContainerViewModel

    var body: some View {
        VStack {
            Text("Artworks IDs:")
                .fontWeight(.light)
            List {
                ForEach(0..<artist.artworkIds.count) { i in
                  Text(verbatim: "\(self.artist.artworkIds[i])")
                        .bold()
                }
            }
            Button {
                self.routeModel.pop()
            } label: {
                ButtonLabel(title: "Go Back", isGreen: false)
            }
            .padding()
        }
    }
}

struct ArtistsWorksScreen_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsWorksScreen(artist: ArtistData(id: 0, title: "", birthDate: 0, birthPlace: "", deathDate: 0, artworkIds: [0]))
    }
}
