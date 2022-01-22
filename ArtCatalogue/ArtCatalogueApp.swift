//
//  ArtCatalogueApp.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 15.1.2022.
//

import SwiftUI

@main
struct ArtCatalogueApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView().environmentObject(ConfigManager.shared.router)
        }
    }
}
