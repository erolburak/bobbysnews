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
        app.buttons["Reset"].buttons["ResetConfirmationDialogButton"].tap()
        /// Check if `EmptyApiKeyMessage` exists
        XCTAssertTrue(app.staticTexts["EmptyApiKeyMessage"].exists)
    }

    @MainActor
    private func setCategory(with app: XCUIApplication) {
        /// Show category picker
        app.staticTexts["General"].tap()
        /// Set category to `General`
        app.buttons["General"].firstMatch.tap()
    }
}
