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
        let backButton = app.buttons.element(boundBy: .zero)
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()
    }

    @MainActor
    private func resetApp(with app: XCUIApplication) {
        /// Open settings menu
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
        settingsImage.tap()
        /// Open reset confirmation dialog
        let resetButton = app.buttons["ResetButton"]
        XCTAssertTrue(resetButton.waitForExistence(timeout: 5))
        resetButton.tap()
        /// Confirm reset
        let resetConfirmationDialogButton = app.buttons["ResetConfirmationDialogButton"]
        XCTAssertTrue(resetConfirmationDialogButton.waitForExistence(timeout: 5))
        resetConfirmationDialogButton.tap()
        /// Check if `EmptySelectedApiKeyMessage` exists
        let emptySelectedApiKeyMessage = app.staticTexts["EmptySelectedApiKeyMessage"]
        XCTAssertTrue(emptySelectedApiKeyMessage.waitForExistence(timeout: 5))
    }

    @MainActor
    private func setCategory(with app: XCUIApplication) {
        /// Open settings menu
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
        settingsImage.tap()
        /// Open category picker
        let categoryPicker = app.buttons["CategoryPicker"]
        XCTAssertTrue(categoryPicker.waitForExistence(timeout: 5))
        categoryPicker.tap()
        /// Set selected category to first match
        let categoryPickerItem = app.buttons["CategoryPickerItem"].firstMatch
        XCTAssertTrue(categoryPickerItem.waitForExistence(timeout: 5))
        categoryPickerItem.tap()
    }
}
