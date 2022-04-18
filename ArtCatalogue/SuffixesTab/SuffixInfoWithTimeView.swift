//
//  SuffixInfoWithTimeView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 28.3.2022.
//

import SwiftUI

public struct SuffixInfoWithTimeView: View {
    @StateObject var viewModel: SuffixesViewModel

    @State public var index: Int

    public var body: some View {
        HStack {
            Text((index > -1 && index < viewModel.debouncedResult.count) ?
                 viewModel.debouncedResult[index].suffix : "")
            Spacer()
            Text((index > -1 && index < viewModel.debouncedResult.count) ?
                 String(viewModel.debouncedResult[index].timeEst) : "")
        }
        .frame(height: 40)
    }
}
