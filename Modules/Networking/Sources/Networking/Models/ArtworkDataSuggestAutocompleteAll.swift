//
// ArtworkDataSuggestAutocompleteAll.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ArtworkDataSuggestAutocompleteAll: Codable, Hashable {

    public var input: [AnyCodable]?
    public var weight: Double
    public var contexts: ArtworkDataContexts?

    public init(input: [AnyCodable]? = nil, weight: Double, contexts: ArtworkDataContexts? = nil) {
        self.input = input
        self.weight = weight
        self.contexts = contexts
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case input
        case weight
        case contexts
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(input, forKey: .input)
        try container.encode(weight, forKey: .weight)
        try container.encodeIfPresent(contexts, forKey: .contexts)
    }
}
