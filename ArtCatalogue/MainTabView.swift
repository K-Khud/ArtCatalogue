//
//  MainTabView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack(alignment: .top) {
        TabView(selection: $router.tabSelection, content: {
            NavigationContainerView(transition: Transition.custom(.opacity), content: {
                ArtworksScreenView(worksViewModel: router.artworksViewModel)
            })
                .tabItem {
                    Label("Artworks", systemImage: "photo.artframe")
            }.tag(0)

            NavigationContainerView(transition: Transition.custom(.opacity), content: {
                ArtistsScreenView(artistsViewModel: router.artistsViewModel)
            })
                .tabItem {
                Label("Artists", systemImage: "person")
            }.tag(1)
            NavigationContainerView(transition: Transition.custom(.opacity), content: {
                SuffixesScreenView(viewModel: router.suffixesViewModel, isAscOrder: true)
            })
                .tabItem {
                Label("Suffixes", systemImage: "rectangle.and.pencil.and.ellipsis")
            }.tag(2)
        })
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
