//
// ResponseArtists.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ResponseArtists: Codable, Hashable {

    public var pagination: Pagination
    public var data: [ArtistData]
    public var info: Info
    public var config: Config

    public init(pagination: Pagination, data: [ArtistData], info: Info, config: Config) {
        self.pagination = pagination
        self.data = data
        self.info = info
        self.config = config
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case pagination
        case data
        case info
        case config
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pagination, forKey: .pagination)
        try container.encode(data, forKey: .data)
        try container.encode(info, forKey: .info)
        try container.encode(config, forKey: .config)
    }
}
