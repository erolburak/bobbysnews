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
        app.openDetailView(with: app)
        closeDetailView(with: app)
        changeApiKey(with: app)
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
    private func changeApiKey(with app: XCUIApplication) {
        /// Open settings menu
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
        settingsImage.tap()
        /// Open api key picker
        let apiKeyPickerButton = app.buttons["API key selection"]
        XCTAssertTrue(apiKeyPickerButton.waitForExistence(timeout: 5))
        apiKeyPickerButton.tap()
        /// Change api key to `2`
        let apiKeyPickerItemButton = app.buttons["ApiKeyPickerItem2"]
        XCTAssertTrue(apiKeyPickerItemButton.waitForExistence(timeout: 5))
        apiKeyPickerItemButton.tap()
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
        /// Check if `ResetConfirmationDialogButton` exists
        let resetConfirmationDialogButton = app.buttons["ResetConfirmationDialogButton"]
        XCTAssertTrue(resetConfirmationDialogButton.waitForExistence(timeout: 5))
        /// Close reset confirmation dialog
        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(resetConfirmationDialogButton.waitForExistence(timeout: 5))
        cancelButton.tap()
    }
}
