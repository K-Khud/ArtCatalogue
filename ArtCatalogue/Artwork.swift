//
//  Artwork.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 22.1.2022.
//

import Foundation
import Networking

struct Artwork: Codable, Hashable, Identifiable {
    static func == (lhs: Artwork, rhs: Artwork) -> Bool {
        return lhs.id == rhs.id
    }

    var id = UUID()
    var modelData: ModelData
    var saved: Bool = false
}
