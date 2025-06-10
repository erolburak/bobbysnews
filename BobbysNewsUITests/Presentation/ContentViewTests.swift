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
        let closeDetailViewButton = app.buttons["BackButton"].firstMatch
        XCTAssertTrue(closeDetailViewButton.waitForExistence(timeout: 1))
        closeDetailViewButton.tap()
    }

    @MainActor
    private func resetApp(with app: XCUIApplication) {
        /// Show settings menu
        let settingsMenu = app.buttons["SettingsMenu"]
        XCTAssertTrue(settingsMenu.waitForExistence(timeout: 1))
        settingsMenu.tap()
        /// Show reset confirmation dialog
        let resetButton = app.buttons["ResetButton"]
        XCTAssertTrue(resetButton.waitForExistence(timeout: 1))
        resetButton.tap()
        /// Confirm reset
        let resetConfirmationDialogButton = app.buttons["ResetConfirmationDialogButton"].firstMatch
        XCTAssertTrue(resetConfirmationDialogButton.waitForExistence(timeout: 1))
        resetConfirmationDialogButton.tap()
        /// Check if `EmptyApiKeyMessage` exists
        let emptyApiKeyMessage = app.staticTexts["EmptyApiKeyMessage"]
        XCTAssertTrue(emptyApiKeyMessage.waitForExistence(timeout: 1))
    }

    @MainActor
    private func setCategory(with app: XCUIApplication) {
        /// Show category picker
        let categoryPicker = app.staticTexts["General"]
        XCTAssertTrue(categoryPicker.waitForExistence(timeout: 1))
        categoryPicker.tap()
        /// Set category to `General`
        let categoryGeneralPickerItem = app.buttons["General"].firstMatch
        XCTAssertTrue(categoryGeneralPickerItem.waitForExistence(timeout: 1))
        categoryGeneralPickerItem.tap()
    }
}
