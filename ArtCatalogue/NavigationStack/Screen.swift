//
//  Screen.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import Foundation
import SwiftUI

struct Screen: Identifiable, Equatable {
    let id = UUID().uuidString
    let view: AnyView

    public static func == (lhs: Screen, rhs: Screen) -> Bool {
        return lhs.id == rhs.id
    }
}
