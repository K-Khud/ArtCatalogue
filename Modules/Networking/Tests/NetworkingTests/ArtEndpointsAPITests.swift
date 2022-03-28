//
//  ArtEndpointsAPITests.swift
//  
//
//  Created by Ekaterina Khudzhamkulova on 26.3.2022.
//

import XCTest
import Networking

class ArtEndpointsAPITests: XCTestCase {

    func testBasicRequestGeneration() {
        let basePath = OpenAPIClientAPI.basePath
        let localVariableRequestBuilder = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        XCTAssertEqual(request?.url, URL(string: "https://api.myapp.com/path"))


    }
}

