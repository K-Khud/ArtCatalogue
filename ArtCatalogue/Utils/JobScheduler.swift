//
//  JobScheduler.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 9.2.2022.
//

import Foundation

class JobScheduler<T: Comparable>: ObservableObject {
    @Published var debouncedResults: [T] = []

    init() {    }

    func scheduleJob(_ job: Job<T>) {
        Task {
            var bufferArray: [T] = debouncedResults
            let newResult = await job.performJob()

            let index = bufferArray.firstIndex(of: newResult)

            guard let index = index else {
                bufferArray.append(newResult)
                debouncedResults = bufferArray.sorted()
                return

            }
            bufferArray[index] = newResult

            debouncedResults = bufferArray.sorted()
            print("bufferResults")

            print(debouncedResults)
        }
    }
}
