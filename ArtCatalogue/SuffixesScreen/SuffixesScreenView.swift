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
            Group {
                HStack {
                    Spacer()
                    LoadSuffixesButton(viewModel: viewModel, buttonTitle: "Load smth with suffixes")
                    Spacer()
                }
                TextFieldView(viewModel: viewModel)
                Picker("Search results", selection: $viewModel.searchResultsSelectedTab) {
                    Text("As is").tag(0)
                    Text("With search time").tag(1)
                }
                .pickerStyle(.segmented)
                if viewModel.searchResultsSelectedTab == 0 {
                    SearchResultView(viewModel: viewModel)
                } else {
                    SearchResultDebouncedView(viewModel: viewModel)
                }
            }
            Group {
                Picker("Suffix lists", selection: $viewModel.allSuffixesSelectedTab) {
                    Text("All").tag(0)
                    Text("Top 10").tag(1)
                }
                .pickerStyle(.segmented)
                if viewModel.allSuffixesSelectedTab == 0 {
                    VStack {
                        ButtonLabel(title: "ASC/DESK", isGreen: false)
                            .onTapGesture {
                                isAscOrder.toggle()
                                viewModel.changeOrder(isAscOrder: isAscOrder)
                            }
                        List {
                            ForEach(viewModel.allSuffixesSorted, id: \.self) { suffixItem in
                                SuffixInfoView(suffix: suffixItem.suffix, count: suffixItem.counter)
                            }
                        }
                        .listStyle(.plain)
                    }
                } else {
                    List {
                        ForEach(viewModel.topTen, id: \.self) { suffixItem in
                            SuffixInfoView(suffix: suffixItem.suffix, count: suffixItem.counter)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}

struct SuffixesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SuffixesScreenView(viewModel: SuffixesViewModel(), isAscOrder: true)
    }
}
