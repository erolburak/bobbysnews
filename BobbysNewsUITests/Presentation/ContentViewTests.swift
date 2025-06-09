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
        app.openDetailView(with: app)
        closeDetailView(with: app)
        resetApp(with: app)
    }

    @MainActor
    private func closeDetailView(with app: XCUIApplication) {
        /// Close detail view
        let closeDetailViewButton = app.buttons["CloseDetailViewButton"]
        XCTAssertTrue(closeDetailViewButton.waitForExistence(timeout: 1))
        closeDetailViewButton.tap()
    }

    @MainActor
    private func resetApp(with app: XCUIApplication) {
        /// Open settings menu
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 1))
        settingsImage.tap()
        /// Open reset confirmation dialog
        let resetButton = app.buttons["ResetButton"]
        XCTAssertTrue(resetButton.waitForExistence(timeout: 1))
        resetButton.tap()
        /// Confirm reset
        let resetConfirmationDialogButton = app.buttons["ResetConfirmationDialogButton"]
        XCTAssertTrue(resetConfirmationDialogButton.waitForExistence(timeout: 1))
        resetConfirmationDialogButton.tap()
        /// Check if `EmptyApiKeyMessage` exists
        let emptyApiKeyMessage = app.staticTexts["EmptyApiKeyMessage"]
        XCTAssertTrue(emptyApiKeyMessage.waitForExistence(timeout: 1))
    }

    @MainActor
    private func setCategory(with app: XCUIApplication) {
        /// Open category menu
        let categoryMenu = app.staticTexts["General"]
        XCTAssertTrue(categoryMenu.waitForExistence(timeout: 5))
        categoryMenu.tap()
        /// Set category to `General`
        let categoryButton = app.buttons["General"]
        XCTAssertTrue(categoryButton.waitForExistence(timeout: 1))
        categoryButton.tap()
    }
}
