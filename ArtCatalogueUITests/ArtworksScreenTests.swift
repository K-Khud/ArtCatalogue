//
//  ArtworksScreenTests.swift
//  ArtCatalogueUITests
//
//  Created by Ekaterina Khudzhamkulova on 29.3.2022.
//

import XCTest

class ArtworksScreenTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLoadingArtworks() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artworks"].tap()
        let initialCount = app.tables.cells.count
        sleep(2)
        let newCount = app.tables.count
        XCTAssert(newCount > initialCount)
    }

    func testLoadingArtworksBySwiping() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artworks"].tap()
        sleep(2)
        let initialCount = app.tables.cells.count
        app.tables.element.swipeUp()
        app.tables.element.swipeUp()
        sleep(2)
        let newCount = app.tables.cells.count
        XCTAssert(newCount > initialCount)
    }

    func testLoadingArtworksByTappingLoad() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artworks"].tap()
        sleep(1)
        app.buttons["Load Artworks"].tap()
        let initialCount = app.tables.cells.count
        sleep(3)
        let newCount = app.tables.cells.count
        XCTAssert(newCount > initialCount)
    }

    func testGoingToDetailsScreen() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artworks"].tap()
        sleep(2)

        app.tables.element.tap()
        XCTAssert(app.buttons["Show Image"].waitForExistence(timeout: 2))
    }

    func testGoingToImageScreen() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Artworks"].tap()
        sleep(1)
        app.tables.element.tap()
        sleep(2)
        app.buttons["Show Image"].tap()
        XCTAssert(app.buttons["Load Image"].waitForExistence(timeout: 2))
    }
}
