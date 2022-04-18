//
//  ArtistDataObject.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 6.3.2022.
//
// swiftlint:disable identifier_name

import Foundation
import RealmSwift

@objc final class ArtistDataObject: Object {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var artistId: Double = 0
    @objc dynamic var title: String = ""
    @objc dynamic var birthDate: Double = 0
    @objc dynamic var birthPlace: String = ""
    @objc dynamic var deathDate: Double = 0
    public var artworkIds = RealmSwift.List<Int>()

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: Double,
                     title: String,
                     birthDate: Double,
                     birthPlace: String, deathDate: Double, artworkIds: [Int]) {
        self.init()
        self.artistId = id
        self.title = title
        self.birthDate = birthDate
        self.birthPlace = birthPlace
        self.deathDate = deathDate
        artworkIds.forEach { artworkId in
            self.artworkIds.append(artworkId)
        }
    }
}
