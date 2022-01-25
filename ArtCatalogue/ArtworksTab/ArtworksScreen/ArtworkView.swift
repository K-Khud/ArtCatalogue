//
//  ArtworkView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 25.1.2022.
//

import UIKit
import SwiftUI
import Networking

struct ArtworkView: View {
    @EnvironmentObject var routeModel: NavigationContainerViewModel
    @State var saved: Bool = false
    @StateObject var worksViewModel: ArtworksViewModel

    var artwork: ArtworkData

    var body: some View {
        Text(artwork.title)
            .modifier(AnimatingCellModifier(cellOpacity: saved ? 0 : 1))
            .modifier(AnimatingOffsetModifier(currentOffsetX: saved ? 200 : 0, currentOffsetY: saved ? 600 : 0))

            .onTapGesture {
                routeModel.push(screenView: LazyView(ArtworkItemView(item: artwork)).toAnyView())
            }
            .onLongPressGesture {
                withAnimation {
                    self.saved.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.delete(at:self.worksViewModel.artworks.firstIndex(where: { $0.id == artwork.id })!)
                }
            }
    }

    func delete(at index: Int) {
        self.worksViewModel.artworks.remove(at: index)
    }
}
