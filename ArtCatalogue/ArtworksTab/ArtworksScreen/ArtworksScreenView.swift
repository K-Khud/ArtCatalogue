//
//  ArtworksScreenView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 15.1.2022.
//

import SwiftUI
import Networking

struct ArtworksScreenView: View {
    
    @StateObject var worksViewModel: ArtworksViewModel = .init()
    
    var body: some View {
        list
    }
    
    var list: some View {
        List {
            HStack {
                Spacer()
                LoadButton(viewModel: worksViewModel, buttonTitle: "Load Artworks")
                Spacer()
            }
            ForEach(worksViewModel.artworks) { artwork in
                ArtworkView(worksViewModel: worksViewModel, artwork: artwork)
                    .onAppear() {
                        if worksViewModel.artworks.isLast(artwork) {
                            worksViewModel.load()
                        }
                    }
            }
        }
        .listStyle(.plain)
    }
    func removeRows(at index: Int) {
        worksViewModel.artworks.remove(at: index)
    }
}

struct ArtworksScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworksScreenView()
    }
}
