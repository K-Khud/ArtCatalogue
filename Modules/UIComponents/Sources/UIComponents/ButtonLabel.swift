//
//  ButtonLabel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 25.1.2022.
//

import SwiftUI

public struct ButtonLabel: View {
    public init(title: String, isGreen: Bool) {
        self.title = title
        self.isGreen = isGreen
    }

    public var title: String
    public var isGreen: Bool

    public var body: some View {
        Text(title)
            .padding()
            .foregroundColor(.white)
            .background(isGreen ? Colors.blueGreen : Colors.freesia)
            .cornerRadius(8)
    }
}

public struct ButtonLabel_Previews: PreviewProvider {
    public static var previews: some View {
        ButtonLabel(title: "Title", isGreen: true)
    }
}
