//
//  SnapshotView.swift
//  Artworks WidgetExtension
//
//  Created by Ekaterina Khudzhamkulova on 5.2.2022.
//

import SwiftUI
import UIComponents

struct SnapshotView: View {
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Rectangle()
                    .fill(Colors.blueGreen)
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height,
                        alignment: .center
                    )
            }
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Artworks")
                        .foregroundColor(Colors.freesia)
                        .background(.thinMaterial)
                        .cornerRadius(6)
                    Text("Artists")
                        .foregroundColor(Colors.coral)
                        .background(.thinMaterial)
                        .cornerRadius(6)
                    Text("Suffixes")
                        .foregroundColor(Colors.fuchsia)
                        .background(.thinMaterial)
                        .cornerRadius(6)
                }
                .padding(.vertical)
                VStack {
                    Text("sky 2")
                    Text("man 1")
                }
                .background(ContainerRelativeShape().fill(.ultraThinMaterial))
            }

        }

    }
}

struct SnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotView()
    }
}
