//
//  ArtworksViewModel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 15.1.2022.
//

import Networking
import SwiftUI
import UIComponents

final class ArtworksViewModel: ObservableObject, Loader {

    @Injected var network: NetworkService?

    @Published var artworks: [ArtworkData] = []
    @Published var isPageLoading: Bool = false

    var page: Int = 0

    func load(_ data: Codable? = nil) {
        guard isPageLoading == false else {
            return
        }
        isPageLoading = true

        page += 1

        DispatchQueue.global(qos: .background).async {
            self.network?.getArtworks(page: self.page, completion: { data, _ in

                self.artworks.append(contentsOf: data?.data ?? [])
                self.isPageLoading = false

            })
        }
    }
}
