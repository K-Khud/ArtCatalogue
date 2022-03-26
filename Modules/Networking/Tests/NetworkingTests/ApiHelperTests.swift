//
//  ApiHelperTests.swift
//  
//
//  Created by Ekaterina Khudzhamkulova on 26.3.2022.
//

import XCTest
@testable import Networking

class ApiHelperTests: XCTestCase {
    let dictWithNil: [String : Any?] = ["0": nil, "1": 1, "2": "2", "3": false]

    func testRejectNil() throws {
        XCTAssertNil(APIHelper.rejectNil(dictWithNil)?["0"])
    }

    func testRejectNilHeaders() throws {
        XCTAssertNil(APIHelper.rejectNilHeaders(dictWithNil)["0"])
    }

    func testConvertBoolToString() throws {
        let falseString = APIHelper.convertBoolToString(dictWithNil)?["3"] as? String
        XCTAssertEqual("false", falseString)
    }

    func testMapValuesToQueryItems() throws {
        let query = APIHelper.mapValuesToQueryItems(dictWithNil)!
        let first = URLQueryItem(name: "1", value: "1")
        let second = URLQueryItem(name: "3", value: "false")
        let third = URLQueryItem(name: "2", value: "2")

        XCTAssertTrue(query.contains(first))
        XCTAssertTrue(query.contains(second))
        XCTAssertTrue(query.contains(third))
        XCTAssertTrue(query.count == 3)
    }


}
