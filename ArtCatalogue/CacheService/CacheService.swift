//
//  CacheService.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 15.2.2022.
//

import Foundation
import Networking
import RealmSwift

public final class CacheService {
    private let realm: Realm

    public convenience init() throws {
        try self.init(realm: Realm())
    }

    internal init(realm: Realm) {
        self.realm = realm
    }

    func queryObjects<T: Object>(with type: T.Type) throws -> Results<T> {
        return realm.objects(T.self)
    }


    func add<T: Object>(_ value: T) {
        do {
            try realm.write({
                realm.add(value)
            })
            print("Success in saving data into cache")

        } catch {
            print("Error adding data to realm: \(error.localizedDescription)")
        }
    }
}

class ArtistsCache: Object {
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

@objc public final class ArtistDataObject: Object {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var artistId: Double = 0
    @objc dynamic var title: String = ""
    @objc dynamic var birthDate: Double = 0
    @objc dynamic var birthPlace: String = ""
    @objc dynamic var deathDate: Double = 0
    var artworkIds = RealmSwift.List<Int>()

    public override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: Double, title: String, birthDate: Double, birthPlace: String, deathDate: Double, artworkIds: [Int]) {
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
public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

extension ArtistData: Persistable {
    public init(managedObject: ArtistDataObject) {
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

    public func managedObject() -> ArtistDataObject {
        let artist = ArtistDataObject(id: id,
                                      title: title,
                                      birthDate: birthDate ?? 0,
                                      birthPlace: birthPlace ?? "",
                                      deathDate: deathDate ?? 0,
                                      artworkIds: artworkIds)
        return artist
    }
}

