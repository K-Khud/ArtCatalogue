//
//  File.swift
//  
//
//  Created by Ekaterina Khudzhamkulova on 20.3.2022.
//

import Foundation
import SwiftUI

public protocol SearchSource: ObservableObject {

    var searchText: String { get set }
}
