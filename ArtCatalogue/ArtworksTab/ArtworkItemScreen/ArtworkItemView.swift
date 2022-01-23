//
//  ArtworkItemView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//


import SwiftUI
import Networking

struct ArtworkItemView: View {
    @State var item: ArtworkData
    @EnvironmentObject var routeModel: NavigationContainerViewModel

    var body: some View {
        VStack {
            Text("Artwork title:")
                .fontWeight(.light)
            Text(item.title)
                .bold()
                .padding()
            Text("Artist")
                .fontWeight(.light)
            Text(item.artistDisplay)
            Text(item.dateDisplay)
                .padding()

            Text("Origin")
                .fontWeight(.light)
            Text(item.placeOfOrigin)
                .padding()

            HStack {
                Spacer()
                Button {
                    routeModel.push(screenView: LazyView(ArtImageScreen(artwork: item)).toAnyView())
                } label: {
                    Text("Show Image")
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


