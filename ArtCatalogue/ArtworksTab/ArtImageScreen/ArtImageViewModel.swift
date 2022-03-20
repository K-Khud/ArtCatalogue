//
//  ArtImageViewModel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI
import Networking

final class ArtImageViewModel: ObservableObject, Loader  {
    // инжектинг в переменные инстанса класса

    @Injected var network: NetworkService?

    @Published var artImage: UIImage = UIImage()
    @Published var isImageLoading: Bool = false

    init() {}

    var body: some View {
            Text("")
    }

    func load(_ data: Codable?) {
        guard let data = data as? ArtworkData else {
            return
        }

        guard isImageLoading == false else {
            return
        }
        isImageLoading = true

        DispatchQueue.global(qos: .background).async {
            self.network?.getImage(imageId: data.imageId ?? "",
                                          iiifUrl: "https://www.artic.edu/iiif/2",
                                          completion: { data, error in
                if let data = data {
                    if let image = UIImage(data: data) {
                        self.artImage = image
                    }
                }
                self.isImageLoading = false

            })
        }
    }
}
