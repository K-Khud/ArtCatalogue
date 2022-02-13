//
//  Router.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import Foundation
import SwiftUI

class Router : ObservableObject {
    @Published var tabSelection: Int = 2
    var artworksViewModel: ArtworksViewModel = ArtworksViewModel()
    var artistsViewModel: ArtistsViewModel = ArtistsViewModel()
    var scheduler: JobScheduler = JobScheduler<SearchResult>()
    var suffixesViewModel: SuffixesViewModel = SuffixesViewModel()

}
