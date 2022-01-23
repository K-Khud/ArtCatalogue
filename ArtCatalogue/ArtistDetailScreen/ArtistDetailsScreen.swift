//
//  ArtistDetailsScreen.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 23.1.2022.
//

import SwiftUI
import Networking

struct ArtistDetailsScreen: View {
    @State var item: ArtistData
    @EnvironmentObject var routeModel: NavigationContainerViewModel

    var body: some View {
        VStack {
            Text("Name:")
                .fontWeight(.light)
            Text(item.title)
                .bold()
                .padding()
            Text("Date of Birth")
                .fontWeight(.light)
            Text(String(item.birthDate ?? 0))

                .padding()

            HStack {
                Spacer()
                Button {
                    routeModel.push(screenView: LazyView(ArtistsWorksScreen(artist: item)).toAnyView())
                } label: {
                    Text("Show Artworks")
                        .padding()
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
                Button {
                    self.routeModel.pop()
                } label: {
                    Text("Go Back")
                        .padding()
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()

            }
        }
    }
}

struct ArtistDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ArtistDetailsScreen(item: ArtistData(id: 0, title: "", birthDate: 0, birthPlace: "", deathDate: "", artworkIds: []))
    }
}
