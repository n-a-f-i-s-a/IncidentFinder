//
//  IncidentFinderUITests.swift
//  IncidentFinderUITests
//
//  Created by Nafisa Rahman on 28/2/2023.
//

import XCTest

final class IncidentFinderUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments.append("Testing")
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testExample() throws {
        testList()
        testDetails()
    }
    
    private func testList() {
        let cell = app.collectionViews.cells.element(boundBy:0)
        if cell.waitForExistence(timeout: 1.0){
            XCTAssertTrue(app.collectionViews.staticTexts["Pending"].exists)
            XCTAssertTrue(app.collectionViews.staticTexts["Out of control"].exists)
            XCTAssertTrue(app.collectionViews.staticTexts["Under control"].exists)
            XCTAssertTrue(app.collectionViews.staticTexts["On Scene"].exists)
        }
    }
    
    private func testDetails() {
        app.collectionViews.cells.element(boundBy:0).tap()
        if app.staticTexts["Location"].waitForExistence(timeout: 1) {
            XCTAssertTrue(app.staticTexts["Location"].exists)
            XCTAssertTrue(app.staticTexts["GREENWAY"].exists)
            XCTAssertTrue(app.staticTexts["Status"].exists)
            XCTAssertTrue(app.staticTexts["Pending"].exists)
            XCTAssertTrue(app.staticTexts["Type"].exists)
            XCTAssertTrue(app.staticTexts["Ambulance Response"].exists)
            XCTAssertTrue(app.staticTexts["Call Time"].exists)
            XCTAssertFalse(app.staticTexts["Description"].exists)
        }
    }
}
