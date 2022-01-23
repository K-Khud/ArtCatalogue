//
// ArtworkData.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ArtworkData: Codable, Hashable, Identifiable {

    public var id: Double
    public var title: String
    public var dateDisplay: String
    public var artistDisplay: String
    public var placeOfOrigin: String
    public var imageId: String

    public init(id: Double, title: String, imageId: String, dateDisplay: String, artistDisplay: String, placeOfOrigin: String) {
        self.id = id
        self.title = title
        self.dateDisplay = dateDisplay
        self.artistDisplay = artistDisplay
        self.placeOfOrigin = placeOfOrigin
        self.imageId = imageId
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case title
        case dateDisplay = "date_display"
        case artistDisplay = "artist_display"
        case placeOfOrigin = "place_of_origin"
        case imageId = "image_id"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(dateDisplay, forKey: .dateDisplay)
        try container.encode(artistDisplay, forKey: .artistDisplay)
        try container.encode(placeOfOrigin, forKey: .placeOfOrigin)
        try container.encode(imageId, forKey: .imageId)
    }
}

