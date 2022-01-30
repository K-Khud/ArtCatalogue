//
//  ArtworksScreenView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 15.1.2022.
//

import SwiftUI
import Networking

struct ArtworksScreenView: View {
    
    @StateObject var worksViewModel: ArtworksViewModel
    @State var email = "" {
        didSet {
            print("set!")
        }
    }

    var body: some View {
        list
    }
    
    var list: some View {
        VStack {
            HStack {
                Spacer()
                LoadButton(viewModel: worksViewModel, buttonTitle: "Load Artworks")
                Spacer()
            }
            List {
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
            TextFieldView(worksViewModel: worksViewModel)
        }
    }

    func removeRows(at index: Int) {
        worksViewModel.artworks.remove(at: index)
    }
}

struct ArtworksScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworksScreenView(worksViewModel: ArtworksViewModel())
    }
}

struct TextFieldView: View {
    @ObservedObject var worksViewModel: ArtworksViewModel

    var body: some View {
        TextField("Enter suffix", text: $worksViewModel.suffix)
            .padding(.horizontal)
            .background(.thinMaterial)
            .cornerRadius(8)
            .frame(height: 30, alignment: .leading)
//            .onChange(of: email) { text in
//                print(text)
//            }

    }
}
