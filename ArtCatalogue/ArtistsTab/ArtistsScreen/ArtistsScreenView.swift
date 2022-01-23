//
//  ArtistsScreenView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 23.1.2022.
//

import SwiftUI
import Networking

struct ArtistsScreenView: View {
    @StateObject var artistsViewModel: ArtistsViewModel = .init()

    var body: some View {
        list
    }

    var list: some View {
        List {
            HStack {
                Spacer()
                LoadArtistsButton(viewModel: artistsViewModel, buttonTitle: "Load Artists")
                Spacer()
            }
            ForEach(artistsViewModel.artists) { artist in
                ArtistView(artistsViewModel: artistsViewModel, artist: artist)
                    .onAppear() {
                        if artistsViewModel.artists.isLast(artist) {
                            artistsViewModel.load()
                        }
                    }
            }
        }
        .listStyle(.plain)
    }
    func removeRows(at index: Int) {
        artistsViewModel.artists.remove(at: index)
    }
}

struct ArtistView: View {
    @EnvironmentObject var routeModel: NavigationContainerViewModel
    @State var saved: Bool = false
    @StateObject var artistsViewModel: ArtistsViewModel

    var artist: ArtistData

    var body: some View {
        Text(artist.title)
            .modifier(AnimatingCellModifier(cellOpacity: saved ? 0 : 1))
            .modifier(AnimatingOffsetModifier(currentOffsetX: saved ? 200 : 0, currentOffsetY: saved ? 600 : 0))

            .onTapGesture {
                routeModel.push(screenView: LazyView(ArtistDetailsScreen(item: artist)).toAnyView())
            }
            .onLongPressGesture {
                withAnimation {
                    self.saved.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.delete(at:self.artistsViewModel.artists.firstIndex(where: { $0.id == artist.id })!)
                }
            }
    }

    func delete(at index: Int) {
        self.artistsViewModel.artists.remove(at: index)
    }
}

struct ArtistsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsScreenView()
    }
}
