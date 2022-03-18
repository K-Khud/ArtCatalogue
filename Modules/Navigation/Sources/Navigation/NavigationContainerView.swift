//
//  NavigationContainerView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.1.2022.
//

import SwiftUI

public struct NavigationContainerView<Content: View>: View {
    @ObservedObject var viewModel = NavigationContainerViewModel()

    private let content: Content
    private let animation: Animation = .easeOut(duration: 0.3)
    private let transition: (push: AnyTransition, pop: AnyTransition)

    public init(transition: Transition, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        switch transition {
        case .none:
            self.transition = (.identity , .identity)
        case .custom(let transition):
            self.transition = (transition, transition)
        }
    }

    public var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return ZStack {
            if isRoot {
                self.content.environmentObject(self.viewModel)
                    .animation(animation)
                    .transition(viewModel.navigationType == .push ? transition.push: transition.pop)
            } else {
                viewModel.currentScreen?.view.environmentObject(self.viewModel)
                    .animation(animation)
                    .transition(viewModel.navigationType == .push ? transition.push: transition.pop)
            }
        }
    }
}

