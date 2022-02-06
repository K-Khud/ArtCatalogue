//
//  PlaceholderView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 5.2.2022.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(Colors.fuchsia)
                .frame(
                    width: geo.size.width,
                    height: geo.size.height,
                    alignment: .center
                )
        }
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
