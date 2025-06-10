//
//  XCUIApplication+Extension.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 13.09.23.
//

import XCTest

extension XCUIApplication {
    // MARK: - Methods

    func appLaunch() -> XCUIApplication {
        /// Set launch arguments to `-Testing`
        launchArguments = ["–Testing"]
        /// Launch app
        launch()
        /// Set device orientation to `portrait`
        XCUIDevice.shared.orientation = .portrait
        /// Set API key if needed
        let emptyApiKeyMessage = staticTexts["EmptyApiKeyMessage"]
        if emptyApiKeyMessage.waitForExistence(timeout: 1) {
            setApiKey(with: self)
        }
        /// Set country if needed
        let emptyCountryMessage = staticTexts["EmptyCountryMessage"]
        if emptyCountryMessage.waitForExistence(timeout: 1) {
            setCountry(with: self)
        }
        return self
    }

    func showDetailView(with app: XCUIApplication) {
        /// Show detail view
        let navigationLink = app.buttons["NavigationLink"]
        XCTAssertTrue(navigationLink.waitForExistence(timeout: 1))
        navigationLink.tap()
    }

    private func setApiKey(with app: XCUIApplication) {
        /// Show settings menu
        let settingsMenu = app.buttons["SettingsMenu"]
        XCTAssertTrue(settingsMenu.waitForExistence(timeout: 1))
        settingsMenu.tap()
        /// Show API key alert
        let apiKeyAddEditButton = app.buttons["ApiKeyAddEditButton"]
        XCTAssertTrue(apiKeyAddEditButton.waitForExistence(timeout: 1))
        apiKeyAddEditButton.tap()
        /// Set API key to `Test`
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.waitForExistence(timeout: 1))
        textField.doubleTap()
        textField.typeText("Test")
        /// Confirm API key
        let apiKeyDoneButton = app.buttons["ApiKeyDoneButton"].firstMatch
        XCTAssertTrue(apiKeyDoneButton.waitForExistence(timeout: 1))
        apiKeyDoneButton.tap()
    }

    private func setCountry(with app: XCUIApplication) {
        /// Show settings menu
        let settingsMenu = app.buttons["SettingsMenu"]
        XCTAssertTrue(settingsMenu.waitForExistence(timeout: 1))
        settingsMenu.tap()
        /// Show country picker
        let countryPicker = app.buttons["CountryPicker"]
        XCTAssertTrue(countryPicker.waitForExistence(timeout: 1))
        countryPicker.tap()
        /// Set country to first match
        let countryPickerItem = app.buttons["CountryPickerItem"].firstMatch
        XCTAssertTrue(countryPickerItem.waitForExistence(timeout: 1))
        countryPickerItem.tap()
    }
}
