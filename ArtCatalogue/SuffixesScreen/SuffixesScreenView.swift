//
//  SuffixesScreenView.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 1.2.2022.
//

import SwiftUI

struct SuffixesScreenView: View {
    @StateObject var viewModel: SuffixesViewModel
    @State var isAscOrder: Bool
    var body: some View {
        list
    }


    var list: some View {
        VStack {
            HStack {
                Spacer()
                LoadSuffixesButton(viewModel: viewModel, buttonTitle: "Load smth with suffixes")
                Spacer()
            }
            TextFieldView(viewModel: viewModel)
            List {
                ForEach(viewModel.searchResult, id: \.self) { searchResult in
                    SearchResultView(suffix: searchResult.suffix, count: searchResult.counter)
                }
            }
            Picker("Suffix lists", selection: $viewModel.selectedPickerTab) {
                Text("All").tag(0)
                Text("Top 10").tag(1)
            }
            .pickerStyle(.segmented)
            if viewModel.selectedPickerTab == 0 {
                VStack {
                    ButtonLabel(title: "ASC/DESK", isGreen: false)
                        .onTapGesture {
                            isAscOrder.toggle()
                            viewModel.changeOrder(isAscOrder: isAscOrder)
                        }
                    List {
                        ForEach(viewModel.allSuffixesSorted, id: \.self) { suffixItem in
                            SearchResultView(suffix: suffixItem.suffix, count: suffixItem.counter)
                        }
                    }
                    .listStyle(.plain)
                }
            } else {
                List {
                    ForEach(viewModel.topTen, id: \.self) { suffixItem in
                        SearchResultView(suffix: suffixItem.suffix, count: suffixItem.counter)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

struct SuffixesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SuffixesScreenView(viewModel: SuffixesViewModel(), isAscOrder: true)
    }
}
