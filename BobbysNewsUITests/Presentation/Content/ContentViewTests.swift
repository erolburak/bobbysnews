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
        app.buttons["BackButton"].waitForExistence().tap()
    }

    @MainActor
    private func resetApp(with app: XCUIApplication) {
        /// Show settings menu
        app.buttons["SettingsMenu"].waitForExistence().tap()
        /// Show reset confirmation dialog
        app.buttons["ResetButton"].waitForExistence().tap()
        /// Confirm reset
        app.buttons["ResetConfirmationDialogButton"].firstMatch.waitForExistence().tap()
        /// Check if `EmptyApiKeyMessage` exists
        app.staticTexts["EmptyApiKeyMessage"].waitForExistence()
    }

    @MainActor
    private func setCategory(with app: XCUIApplication) {
        /// Show category picker
        app.staticTexts["General"].waitForExistence().tap()
        /// Set category to `General`
        app.buttons["General"].waitForExistence().tap()
    }

    @MainActor
    private func showCloseWebView(with app: XCUIApplication) {
        /// Show API key add edit viiew
        app.showApiKeyAddEditView(with: app)
        /// Show web view
        app.buttons["ShowWebViewButton"].firstMatch.waitForExistence().tap()
        /// Close web view
        app.buttons["CloseWebViewButton"].waitForExistence().tap()
    }
}
