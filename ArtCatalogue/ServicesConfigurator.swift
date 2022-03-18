//
//  ServicesConfigurator.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.3.2022.
//

import Foundation

final class ServicesConfigurator {
    static let shared = ServicesConfigurator()

    func register() {
        ServiceLocator.shared.addServices(service: NetworkService())
        ServiceLocator.shared.addServices(service: try! CacheService())
    }
}
