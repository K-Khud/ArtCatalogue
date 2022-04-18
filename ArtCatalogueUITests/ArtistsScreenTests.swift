//
//  ArtistsScreenTests.swift
//  ArtCatalogueUITests
//
//  Created by Ekaterina Khudzhamkulova on 29.3.2022.
//

import XCTest

class ArtistsScreenTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLoadingArtists() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artists"].tap()
        let initialCount = app.tables.cells.count
        sleep(3)
        let newCount = app.tables.count
        XCTAssert(newCount > initialCount)
    }

    func testLoadingArtistsBySwiping() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artists"].tap()
        sleep(2)
        let initialCount = app.tables.cells.count
        app.tables.element.swipeUp()
        app.tables.element.swipeUp()
        sleep(2)
        let newCount = app.tables.cells.count
        XCTAssert(newCount > initialCount)
    }

    func testLoadingArtistsByTappingLoad() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artists"].tap()
        sleep(1)
        app.buttons["Load Artists"].tap()
        let initialCount = app.tables.cells.count
        sleep(3)
        let newCount = app.tables.cells.count
        XCTAssert(newCount > initialCount)
    }

    func testGoingToDetailsScreen() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artists"].tap()
        sleep(2)
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Don A. DuBroff"].tap()

        XCTAssert(app.buttons["Show Artworks"].waitForExistence(timeout: 2))
    }

    func testGoingToImageScreen() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artists"].tap()
        sleep(1)
        app.tables.staticTexts["Don A. DuBroff"].tap()
        sleep(1)
        app.buttons["Show Artworks"].tap()
        XCTAssert(app.buttons["Go Back"].waitForExistence(timeout: 2))
    }
}
