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

    @Published var artworks: [ArtworkData] = []
    @Published var isPageLoading: Bool = false
    @Published var suffix: String = "" {
        didSet {
            guard suffix.count < 3 else {
                searchSuffixes()
                return
            }
        }
    }

    var page: Int = 0

    var body: some View {
            Text("")
    }

    func load(_ data: ArtworkData? = nil) {
        guard isPageLoading == false else {
            return
        }
        isPageLoading = true

        page += 1

        DispatchQueue.global(qos: .background).async {
            ArtEndpointsAPI.getArtworks(page: self.page, completion: { data, error in

                self.artworks.append(contentsOf: data?.data ?? [])
                self.isPageLoading = false

            })
        }
    }

    private func searchSuffixes() {
        print("Search for: \(suffix)")
    }
}
