//
//  ArtistsCache.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 6.3.2022.
//

import Foundation
import RealmSwift

final class ArtistsCache: Object {
    @objc dynamic var page: Int = 0
    var payload = RealmSwift.List<ArtistDataObject>()

    convenience init(page: Int, payload: [ArtistDataObject]) {
        self.init()
        self.page = page
        payload.forEach { dataObject in
            self.payload.append(dataObject)
        }
    }
}
