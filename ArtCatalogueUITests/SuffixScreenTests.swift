//
//  SuffixScreenTests.swift
//  ArtCatalogueUITests
//
//  Created by Ekaterina Khudzhamkulova on 29.3.2022.
//

import XCTest

class SuffixScreenTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testButtonsExist() throws {
        let app = XCUIApplication()
        app.launch()

        let asIsBtn = app.buttons["As is"]
        let searchTimeBtn = app.buttons["With search time"]
        let allBtn = app/*@START_MENU_TOKEN@*/.buttons["All"]/*[[".segmentedControls.buttons[\"All\"]",".buttons[\"All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let top10Btn = app/*@START_MENU_TOKEN@*/.buttons["Top 10"]/*[[".segmentedControls.buttons[\"Top 10\"]",".buttons[\"Top 10\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let enterTxt = app.textFields["Enter suffix"]
        let loadBtn = app.buttons["Load smth with suffixes"]

        XCTAssertTrue(asIsBtn.exists)
        XCTAssertTrue(searchTimeBtn.exists)
        XCTAssertTrue(allBtn.exists)
        XCTAssertTrue(top10Btn.exists)
        XCTAssertTrue(enterTxt.exists)
        XCTAssertTrue(loadBtn.exists)
    }

    func testFillingSuffixesTable() throws {
        let app = XCUIApplication()
        app.launch()

        let tablesQuery = app.tables
        XCTAssert(tablesQuery.element.waitForExistence(timeout: 5))
    }

    func testAddingSuffixes() throws {
        let app = XCUIApplication()
        app.launch()
        let initialCount = app.tables.cells.count
        app.buttons["Load smth with suffixes"].tap()
        sleep(5)
        let newCount = app.tables.cells.count

        XCTAssert(newCount > initialCount)
    }
}
