//
//  DetailViewTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class DetailViewTests: XCTestCase {
    // MARK: - Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testDetailView() {
        /// Launch app
        let app = XCUIApplication().appLaunch()
        app.openDetailView(with: app)
        openCloseShareView(with: app)
        openCloseWebView(with: app)
    }

    @MainActor
    private func openCloseShareView(with app: XCUIApplication) {
        /// Open share view
        let shareLink = app.buttons["ShareLink"]
        XCTAssertTrue(shareLink.waitForExistence(timeout: 5))
        shareLink.tap()
        /// Close share view
        let closeButton = app.navigationBars["UIActivityContentView"].buttons["Schließen"]
        XCTAssertTrue(closeButton.waitForExistence(timeout: 5))
        closeButton.tap()
    }

    @MainActor
    private func openCloseWebView(with app: XCUIApplication) {
        /// Open web view
        let readButton = app.buttons["ReadButton"]
        XCTAssertTrue(readButton.waitForExistence(timeout: 5))
        readButton.tap()
        /// Close web view
        let closeButton = app.buttons["CloseButton"]
        XCTAssertTrue(closeButton.waitForExistence(timeout: 5))
        closeButton.tap()
    }
}
