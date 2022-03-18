//
//  Screen.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI

public struct Screen: Identifiable, Equatable {
    public let id = UUID().uuidString
    public let view: AnyView

    public static func == (lhs: Screen, rhs: Screen) -> Bool {
        return lhs.id == rhs.id
    }
}
