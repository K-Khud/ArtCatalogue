//
//  LoaderProtocol.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 22.1.2022.
//

import Foundation
import SwiftUI

public protocol Loader: ObservableObject {

    func load(_ data: Codable?)
}
