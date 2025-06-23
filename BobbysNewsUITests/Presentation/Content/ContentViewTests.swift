//
//  ContentViewTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class ContentViewTests: XCTestCase {
    // MARK: - Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testContentView() {
        /// Launch app
        let app = XCUIApplication().appLaunch()
        setCategory(with: app)
        app.showDetailView(with: app)
        closeDetailView(with: app)
        showCloseWebView(with: app)
        resetApp(with: app)
    }

    @MainActor
    private func closeDetailView(with app: XCUIApplication) {
        /// Close detail view
        app.buttons["BackButton"].tap()
    }

    @MainActor
    private func resetApp(with app: XCUIApplication) {
        /// Show settings menu
        app.buttons["SettingsMenu"].tap()
        /// Show reset confirmation dialog
        app.buttons["ResetButton"].tap()
        /// Confirm reset
        let resetConfirmationDialogButton = app.buttons["ResetConfirmationDialogButton"].firstMatch
        resetConfirmationDialogButton.waitForExistence(timeout: 5)
            ? resetConfirmationDialogButton.tap() : XCTFail()
        /// Check if `EmptyApiKeyMessage` exists
        let emptyApiKeyMessage = app.staticTexts["EmptyApiKeyMessage"]
        emptyApiKeyMessage.waitForExistence(timeout: 5)
            ? XCTAssertTrue(emptyApiKeyMessage.exists) : XCTFail()
    }

    @MainActor
    private func setCategory(with app: XCUIApplication) {
        /// Show category picker
        app.staticTexts["General"].tap()
        /// Set category to `General`
        app.buttons["General"].tap()
    }

    @MainActor
    private func showCloseWebView(with app: XCUIApplication) {
        /// Show API key add edit viiew
        app.showApiKeyAddEditView(with: app)
        /// Show web view
        app.buttons["ShowWebViewButton"].firstMatch.tap()
        /// Close web view
        let closeWebViewButton = app.buttons["CloseWebViewButton"]
        closeWebViewButton.waitForExistence(timeout: 5) ? closeWebViewButton.tap() : XCTFail()
    }
}
