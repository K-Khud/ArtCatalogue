//
//  ButtonLabel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 25.1.2022.
//

import SwiftUI

struct ButtonLabel: View {
    var title: String
    var isGreen: Bool

    var body: some View {
        Text(title)
            .padding()
            .foregroundColor(.white)
            .background(isGreen ? Colors.blueGreen : Colors.freesia)
            .cornerRadius(8)
    }
}

struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(title: "Title", isGreen: true)
    }
}
