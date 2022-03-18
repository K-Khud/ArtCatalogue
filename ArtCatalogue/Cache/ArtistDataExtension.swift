//
//  ArtistDataExtension.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 6.3.2022.
//

import Foundation
import RealmSwift
import Networking

extension ArtistData: Persistable {
    init(managedObject: ArtistDataObject) {
        let birthPlace = managedObject.birthPlace
        let deathDate = Double(managedObject.deathDate)
        var artworksIdArray: [Int] = []
        managedObject.artworkIds.forEach { artworkId in
            artworksIdArray.append(artworkId)
        }

        self.init(id: managedObject.artistId,
                  title: managedObject.title,
                  birthDate: managedObject.birthDate,
                  birthPlace: birthPlace,
                  deathDate: deathDate,
                  artworkIds: artworksIdArray)
    }

    func managedObject() -> ArtistDataObject {
        let artist = ArtistDataObject(id: id,
                                      title: title,
                                      birthDate: birthDate ?? 0,
                                      birthPlace: birthPlace ?? "",
                                      deathDate: deathDate ?? 0,
                                      artworkIds: artworkIds)
        return artist
    }
}
