//
//  ArtEndpointsAPITests.swift
//  
//
//  Created by Ekaterina Khudzhamkulova on 26.3.2022.
//

import XCTest
@testable import Networking

class ArtEndpointsAPITests: XCTestCase {

    func testBasicRequestGeneration() {
        let basePath = OpenAPIClientAPI.basePath
        let localVariableRequestBuilder: RequestBuilder<ResponseMock>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()
        let request = localVariableRequestBuilder.init(method: "GET", URLString: basePath, parameters: nil)

        XCTAssertEqual(request.URLString, basePath)
    }

    func testGetArtists() {
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error?
        var responseData: ResponseArtists?
        ArtEndpointsAPI.getArtists(page: 0, completion: { data, error in

            responseError = error
            responseData = data
            promise.fulfill()

        })
        wait(for: [promise], timeout: 10)

        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
    }

    func testGetArtworks() {
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error?
        var responseData: ResponseArtworks?

        ArtEndpointsAPI.getArtworks(page: 0, completion: { data, error in
            responseError = error
            responseData = data

            promise.fulfill()

        })
        wait(for: [promise], timeout: 10)

        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
    }
}

