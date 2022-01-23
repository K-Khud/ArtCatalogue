//
//  ArtistsViewModel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 23.1.2022.
//

import Foundation
import Networking
import SwiftUI

final class ArtistsViewModel: ObservableObject {

    @Published var artists: [ArtistData] = []
    @Published var isPageLoading: Bool = false

    var page: Int = 0

    init() {}

    var body: some View {
            Text("")
    }

    func load() {
        guard isPageLoading == false else {
            return
        }
        isPageLoading = true

        page += 1

        DispatchQueue.global(qos: .background).async {
            ArtEndpointsAPI.getArtists(page: self.page, completion: { data, error in

                self.artists.append(contentsOf: data?.data ?? [])
                self.isPageLoading = false

            })
        }
    }
}
