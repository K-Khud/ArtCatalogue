//
//  ConfigManager.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import Foundation

class ConfigManager {
    static let shared = ConfigManager()

    lazy var router: Router = {
        return Router()
    }()
}
