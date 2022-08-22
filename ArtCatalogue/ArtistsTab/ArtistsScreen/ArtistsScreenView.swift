//
//  ArtistsScreenView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 23.1.2022.
//

import SwiftUI
import Networking
import UIComponents

struct ArtistsScreenView: View {
    @StateObject var artistsViewModel: ArtistsViewModel

    var body: some View {
        list
    }

    var list: some View {
        VStack {
            HStack {
                Spacer()
                LoadArtistsButton(buttonTitle: "Load Artists", viewModel: artistsViewModel)
                Spacer()
            }
            List {
                ForEach(artistsViewModel.artists) { artist in
                    ArtistView(artistsViewModel: artistsViewModel, artist: artist)
                        .task() {
                            if artistsViewModel.artists.isLast(artist) {
                                artistsViewModel.load()
                            }
                        }
                }
            }
            .task() {
                artistsViewModel.load()
            }
            .listStyle(.plain)
        }
    }
    func removeRows(at index: Int) {
        artistsViewModel.artists.remove(at: index)
    }
}

struct ArtistsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsScreenView(artistsViewModel: ArtistsViewModel())
    }
}
