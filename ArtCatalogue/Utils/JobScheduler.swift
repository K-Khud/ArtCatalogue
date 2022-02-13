//
//  JobScheduler.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 9.2.2022.
//

import Foundation
//import SwiftUI

class JobScheduler<T: Comparable>: ObservableObject {
    @Published var sortedResults: [T] = []
    @Published private var bufferResults: [T] = []

    init() {
        $bufferResults
            .receive(on: RunLoop.main)
            .assign(to: &$sortedResults)
    }


    func scheduleJob(_ job: Job<T>) {
        Task {
            var bufferArray: [T] = sortedResults
            let newResult = await job.performJob()

            let index = bufferArray.firstIndex(of: newResult)

            guard let index = index else {
                bufferArray.append(newResult)
                bufferResults = bufferArray.sorted()
                return

            }
            bufferArray[index] = newResult

            bufferResults = bufferArray.sorted()

        }
    }
}
