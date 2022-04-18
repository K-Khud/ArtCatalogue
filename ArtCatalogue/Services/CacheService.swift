//
//  CacheService.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 15.2.2022.
//

import Foundation
import RealmSwift

final class CacheService {
    private let realm: Realm

    convenience init() throws {
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

        } catch {
            print("Error adding data to realm: \(error.localizedDescription)")
        }
    }
}
