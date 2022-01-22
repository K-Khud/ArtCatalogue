//
//  ArtworksViewModel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 15.1.2022.
//

import Foundation
import Networking
import SwiftUI

final class ArtworksViewModel: ObservableObject, Loader {

    @Published var artworks: [ModelData] = []
    @Published var isPageLoading: Bool = false

    var page: Int = 0

    init() {}

    var body: some View {
            Text("")
    }

    func load(_ data: ModelData? = nil) {
        guard isPageLoading == false else {
            return
        }
        isPageLoading = true

        page += 1

        DispatchQueue.global(qos: .background).async {
            ArtworksEndpointsAPI.getArtworks(page: self.page, completion: { data, error in

                self.artworks.append(contentsOf: data?.data ?? [])
                self.isPageLoading = false

            })
        }
    }
}
