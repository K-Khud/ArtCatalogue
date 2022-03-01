//
//  FileService.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 1.3.2022.
//

import Foundation

class FileService {
    static func getCacheDirectoryUrl() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
                .appendingPathComponent("testingCache")
    }

    static func getCacheFileUrl() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
                .appendingPathComponent("testingCache")
                .appendingPathComponent("testingCache.txt")
    }

    static func save(_ searchResults: [SearchResult]) {

        guard let cacheDirectoryUrl = getCacheDirectoryUrl() else { return }
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: cacheDirectoryUrl.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectoryUrl,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
            } catch {
                print("Error creating dirrectory: \(error)")
            }
        }
        guard let newFileUrl = getCacheFileUrl() else {
            return
        }

        let jsonData = createString(from: searchResults)

        if !fileManager.fileExists(atPath: newFileUrl.path) {

            fileManager.createFile(atPath: newFileUrl.path, contents: jsonData, attributes: nil)

        } else {
            // update file
            if let fileUpdater = try? FileHandle(forUpdating: newFileUrl) {
                fileUpdater.seekToEndOfFile()
                fileUpdater.write(jsonData)
                fileUpdater.closeFile()
            }
        }

    }

    static private func createString(from results: [SearchResult]) -> Data {
        // creating JSON out of the above array
        var jsonData: Data!

        do {

          let encoder = JSONEncoder()
          encoder.keyEncodingStrategy = .convertToSnakeCase
            jsonData = try encoder.encode(results)

          print(String(data: jsonData, encoding: .utf8)!)

        } catch {
          print(error)
        }
        return jsonData
    }

    static func load() -> [SearchResult] {

        guard let fileUrl = getCacheFileUrl() else { return [] }

        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            guard let cachedArray = try JSONSerialization.jsonObject(with: data, options: []) as? [SearchResult] else {
                return [] }
            print(cachedArray)
            return cachedArray
        } catch {
            print(error)
        }
        return []
    }
}
