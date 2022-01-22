//
//  NavigationContainerViewModel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import Foundation
import SwiftUI

class NavigationContainerViewModel: ObservableObject {
    @Published var currentScreen: Screen?
    var navigationType: NavigationType = .push

    var screenStack = NavigationStack() {
        didSet {
            self.currentScreen = screenStack.top()
        }
    }

    func push(screenView: AnyView) {
        self.navigationType = .push
        let screen = Screen(view: screenView)
        screenStack.push(screen)
    }

    func pop() {
        self.navigationType = .pop
        screenStack.pop()
    }

    func popToRoot() {
        self.navigationType = .popToRoot
        screenStack.popToRoot()
    }
}
