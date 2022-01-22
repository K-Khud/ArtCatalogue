//
//  MainTabView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: Router
//    @State var tabSelection: Int = 0
    var body: some View {
        ZStack(alignment: .top) {
        TabView(selection: $router.tabSelection, content: {
            NavigationContainerView(transition: Transition.custom(.opacity), content: {
                ArtworksScreenView()
            })
                .tabItem {
                    Label("Artworks", systemImage: "photo.artframe")
            }.tag(0)

            VStack {
            Text("Artists")
                Button {
                    self.router.tabSelection = 0
                } label: {
                    Text("Go first")
                        .frame(height: 50)
                }
            }.background(Color.yellow).tabItem {
                Label("Artists", systemImage: "person")
            }.tag(1)
        })
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
