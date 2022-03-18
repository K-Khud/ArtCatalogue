//
//  Transition.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI

public enum Transition {
    case none
    case custom(AnyTransition)
}

public enum NavigationType {
    case pop
    case push
    case popToRoot
}
