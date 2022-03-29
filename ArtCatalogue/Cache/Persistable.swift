//
//  Persistable.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 6.3.2022.
//

import Foundation
import RealmSwift

protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object

    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
