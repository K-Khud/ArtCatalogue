//
//  ArtistsViewModel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 23.1.2022.
//

import Networking
import SwiftUI
import UIComponents

final class ArtistsViewModel: ObservableObject, Loader {

    // инжектинг в переменные инстанса класса

    @Injected var network: NetworkService?

    @Published var artists: [ArtistData] = []
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

    init() {}

    var body: some View {
            Text("")
    }

    func load(_ data: Codable? = nil) {
        guard isPageLoading == false else {
            return
        }
        isPageLoading = true

        page += 1

        DispatchQueue.global(qos: .background).async {
            self.network?.getArtists(page: self.page, completion: { data, error in

                self.artists.append(contentsOf: data?.data ?? [])
                self.isPageLoading = false

            })
        }
    }
    private func searchSuffixes() {
        print("Search for: \(suffix)")
    }
}
