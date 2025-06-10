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
        app.showDetailView(with: app)
        showCloseWebView(with: app)
        showShareView(with: app)
    }

    @MainActor
    private func showCloseWebView(with app: XCUIApplication) {
        /// Show web view
        let showWebViewButton = app.buttons["ShowWebViewButton"]
        XCTAssertTrue(showWebViewButton.waitForExistence(timeout: 1))
        showWebViewButton.tap()
        /// Close web view
        let closeWebViewButton = app.buttons["CloseWebViewButton"]
        XCTAssertTrue(closeWebViewButton.waitForExistence(timeout: 1))
        closeWebViewButton.tap()
    }

    @MainActor
    private func showShareView(with app: XCUIApplication) {
        /// Show share view
        let shareLink = app.buttons["ShareLink"]
        XCTAssertTrue(shareLink.waitForExistence(timeout: 1))
        shareLink.tap()
    }
}
