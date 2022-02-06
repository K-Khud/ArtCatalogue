//
//  WidgetBridget.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 5.2.2022.
//

import Foundation

class WidgetBridget {
    static let shared = WidgetBridget()

    var topThree: [String] = ["doc - 3", "txt - 2", "sky - 1"] {
        didSet {
            print("topThree set to \(topThree)")
        }
    }


}
