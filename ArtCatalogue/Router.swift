//
//  Router.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import Foundation
import SwiftUI

class Router : ObservableObject {
    @Published var tabSelection: Int = 0
    var artworksViewModel: ArtworksViewModel = ArtworksViewModel()
    var artistsViewModel: ArtistsViewModel = ArtistsViewModel()
}
