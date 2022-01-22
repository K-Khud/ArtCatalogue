//
//  ArtworksScreenView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 15.1.2022.
//

import SwiftUI
import Networking

struct ArtworksScreenView: View {
    
    @StateObject var worksViewModel: ArtworksViewModel = .init()
    
    var body: some View {
        list
    }
    
    var list: some View {
        List {
            HStack {
                Spacer()
                LoadButton(viewModel: worksViewModel, buttonTitle: "Load Artworks")
                Spacer()
            }
            ForEach(worksViewModel.artworks) { artwork in
                ArtworkView(worksViewModel: worksViewModel, artwork: artwork)
                    .onAppear() {
                        if worksViewModel.artworks.isLast(artwork) {
                            worksViewModel.load()
                        }
                    }
            }
        }
        .listStyle(.plain)
    }
    func removeRows(at index: Int) {
        worksViewModel.artworks.remove(at: index)
    }
}

struct ArtworkView: View {
    @EnvironmentObject var routeModel: NavigationContainerViewModel
    @State var saved: Bool = false
    @StateObject var worksViewModel: ArtworksViewModel
    
    var artwork: ModelData
    
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

struct AnimatingCellModifier: AnimatableModifier {
    var cellOpacity: Double = 1
    var animatableData: Double {
        get { cellOpacity }
        set { cellOpacity = newValue }
    }
    
    func body(content: Content) -> some View {
        content.opacity(cellOpacity)
    }
}

struct AnimatingOffsetModifier: AnimatableModifier {
    var currentOffsetX: Double = 0
    var currentOffsetY: Double = 0
    
    var animatableX: Double {
        get { currentOffsetX }
        set { currentOffsetX = newValue }
    }
    var animatableY: Double {
        get { currentOffsetY }
        set { currentOffsetY = newValue }
    }
    
    func body(content: Content) -> some View {
        content.offset(x: currentOffsetX, y: currentOffsetY)
    }
}

struct ArtworksScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworksScreenView()
    }
}
