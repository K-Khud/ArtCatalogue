//
//  ArtistView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 1.2.2022.
//
import Networking
import SwiftUI
import Navigation

struct ArtistView: View {
    @EnvironmentObject var routeModel: NavigationContainerViewModel
    @State var saved: Bool = false
    @StateObject var artistsViewModel: ArtistsViewModel

    var artist: ArtistData

    var body: some View {
        Text(artist.title ?? "")
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
                    self.delete(at: self.artistsViewModel.artists.firstIndex(where: { $0.id == artist.id })!)
                }
            }
    }

    func delete(at index: Int) {
        self.artistsViewModel.artists.remove(at: index)
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView(artistsViewModel: ArtistsViewModel(),
                   artist: ArtistData(id: 0,
                                      title: "Title",
                                      birthDate: nil,
                                      birthPlace: nil,
                                      deathDate: nil,
                                      artworkIds: [0]))
    }
}
