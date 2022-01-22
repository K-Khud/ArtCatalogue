//
//  Transition.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import Foundation
import SwiftUI

enum Transition {
    case none
    case custom(AnyTransition)
}

enum NavigationType {
    case pop
    case push
    case popToRoot
}
