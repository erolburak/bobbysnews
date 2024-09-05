//
//  ContentViewTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

@MainActor
final class ContentViewTests: XCTestCase {
    // MARK: - Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    /// Test navigation link to open detail view steps:
    /// 1) Open detail view
    func testNavigationLink() {
        let app = XCUIApplication().appLaunch()
        let navigationLink = app.buttons["NavigationLink"]
        XCTAssertTrue(navigationLink.waitForExistence(timeout: 5))
        navigationLink.tap()
    }

    /// Test api key picker item to change api key steps:
    /// 1) Open settings menu
    /// 2) Open api key picker
    /// 3) Set selected api key to 2
    func testApiKeyPickerItem() {
        let app = XCUIApplication().appLaunch()
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
        settingsImage.tap()
        let apiKeyPicker = app.buttons["API key selection"]
        XCTAssertTrue(apiKeyPicker.waitForExistence(timeout: 5))
        apiKeyPicker.tap()
        let apiKeyPickerItem2 = app.buttons["ApiKeyPickerItem2"]
        XCTAssertTrue(apiKeyPickerItem2.waitForExistence(timeout: 5))
        apiKeyPickerItem2.tap()
    }

    /// Test reset and confirm reset steps:
    /// 1) Open settings menu
    /// 2) Press reset
    /// 3) Check if `ResetConfirmationDialogButton` exists
    func testResetButton() {
        let app = XCUIApplication().appLaunch()
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
        settingsImage.tap()
        let resetButton = app.buttons["ResetButton"]
        XCTAssertTrue(resetButton.waitForExistence(timeout: 5))
        resetButton.tap()
        let resetConfirmationDialogButton = app.buttons["ResetConfirmationDialogButton"]
        XCTAssertTrue(resetConfirmationDialogButton.waitForExistence(timeout: 5))
    }
}
