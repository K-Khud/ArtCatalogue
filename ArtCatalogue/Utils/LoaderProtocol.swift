//
//  LoaderProtocol.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 22.1.2022.
//

import Foundation
import SwiftUI
import Networking

protocol Loader: ObservableObject {
    associatedtype Body: View
    var body: Body { get }

    func load(_ data: Codable?)
}
