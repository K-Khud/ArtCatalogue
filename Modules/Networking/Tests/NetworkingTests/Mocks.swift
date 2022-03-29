//
//  Mocks.swift
//  
//
//  Created by Ekaterina Khudzhamkulova on 28.3.2022.
//

@testable import Networking

public struct ResponseMock: Codable, Hashable {

    public var info: String

    public init(info: String) {
        self.info = info
    }
    public enum CodingKeys: String, CodingKey, CaseIterable {
        case info
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(info, forKey: .info)
    }
}
