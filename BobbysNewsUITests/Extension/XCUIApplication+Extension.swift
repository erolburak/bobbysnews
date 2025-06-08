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
        let app = XCUIApplication()
        /// Set launch arguments to `-testing`
        app.launchArguments = ["–testing"]
        /// Launch app
        app.launch()
        /// Close settings tip if needed
        let closeSettingsTipButton = popovers.buttons["Close"]
        if closeSettingsTipButton.waitForExistence(timeout: 5) {
            closeSettingsTipButton.tap()
        }
        /// Set selected API key if needed
        let emptySelectedApiKeyMessage = app.staticTexts["EmptySelectedApiKeyMessage"]
        if emptySelectedApiKeyMessage.waitForExistence(timeout: 5) {
            setApiKey(with: app)
        }
        /// Set selected country if needed
        let emptySelectedCountryMessage = app.staticTexts["EmptySelectedCountryMessage"]
        if emptySelectedCountryMessage.waitForExistence(timeout: 5) {
            setCountry(with: app)
        }
        return app
    }

    func openDetailView(with app: XCUIApplication) {
        /// Open detail view
        let navigationLink = app.buttons["NavigationLink"]
        XCTAssertTrue(navigationLink.waitForExistence(timeout: 5))
        navigationLink.tap()
    }

    private func setApiKey(with app: XCUIApplication) {
        /// Open settings menu
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
        settingsImage.tap()
        /// Open API key alert
        let apiKeyAddEditButton = app.buttons["ApiKeyAddEditButton"]
        XCTAssertTrue(apiKeyAddEditButton.waitForExistence(timeout: 5))
        apiKeyAddEditButton.tap()
        /// Set API key to first match
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.waitForExistence(timeout: 5))
        textField.doubleTap()
        textField.typeText("Test")
        /// Confirm API key
        let apiKeyDoneButton = app.buttons["ApiKeyDoneButton"]
        XCTAssertTrue(apiKeyDoneButton.waitForExistence(timeout: 5))
        apiKeyDoneButton.tap()
    }

    private func setCountry(with app: XCUIApplication) {
        /// Open settings menu
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
        settingsImage.tap()
        /// Open country picker
        let countryPicker = app.buttons["CountryPicker"]
        XCTAssertTrue(countryPicker.waitForExistence(timeout: 5))
        countryPicker.tap()
        /// Set selected country to first match
        let countryPickerItem = app.buttons["CountryPickerItem"].firstMatch
        XCTAssertTrue(countryPickerItem.waitForExistence(timeout: 5))
        countryPickerItem.tap()
    }
}
