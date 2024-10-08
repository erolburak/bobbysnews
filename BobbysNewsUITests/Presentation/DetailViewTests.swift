//
//  DetailViewTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

@MainActor
final class DetailViewTests: XCTestCase {
    // MARK: - Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    /// Test share link to open share view steps:
    /// 1) Open detail view
    /// 1) Press share
    func testShareLink() {
        let app = XCUIApplication().appLaunch()
        let navigationLink = app.buttons["NavigationLink"]
        if navigationLink.waitForExistence(timeout: 5) {
            navigationLink.tap()
            let shareLink = app.buttons["ShareLink"]
            XCTAssertTrue(shareLink.waitForExistence(timeout: 5))
            shareLink.tap()
        }
    }

    /// Test read button to open web view steps:
    /// 1) Open detail view
    /// 2) Press read
    func testReadButton() {
        let app = XCUIApplication().appLaunch()
        let navigationLink = app.buttons["NavigationLink"]
        if navigationLink.waitForExistence(timeout: 5) {
            navigationLink.tap()
            let readButton = app.buttons["ReadButton"]
            XCTAssertTrue(readButton.waitForExistence(timeout: 5))
            readButton.tap()
        }
    }

    /// Test close button of web view steps:
    /// 1) Open detail view
    /// 2) Press read
    /// 3) Close web view
    func testCloseButton() {
        let app = XCUIApplication().appLaunch()
        let navigationLink = app.buttons["NavigationLink"]
        if navigationLink.waitForExistence(timeout: 5) {
            navigationLink.tap()
            let readButton = app.buttons["ReadButton"]
            XCTAssertTrue(readButton.waitForExistence(timeout: 5))
            readButton.tap()
            let closeButton = app.buttons["CloseButton"]
            XCTAssertTrue(closeButton.waitForExistence(timeout: 5))
            closeButton.tap()
        }
    }
}
