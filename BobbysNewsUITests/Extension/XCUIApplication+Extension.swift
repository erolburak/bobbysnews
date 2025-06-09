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
        /// Close tips if needed
        let closeCategoriesTipButton = popovers.buttons["Close"]
        if closeCategoriesTipButton.waitForExistence(timeout: 1) {
            closeCategoriesTipButton.tap()
        }
        let closeSettingsTipButton = popovers.buttons["Close"]
        if closeSettingsTipButton.waitForExistence(timeout: 1) {
            closeSettingsTipButton.tap()
        }
        /// Set API key if needed
        let emptyApiKeyMessage = app.staticTexts["EmptyApiKeyMessage"]
        if emptyApiKeyMessage.waitForExistence(timeout: 1) {
            setApiKey(with: app)
        }
        /// Set country if needed
        let emptyCountryMessage = app.staticTexts["EmptyCountryMessage"]
        if emptyCountryMessage.waitForExistence(timeout: 1) {
            setCountry(with: app)
        }
        return app
    }

    func openDetailView(with app: XCUIApplication) {
        /// Open detail view
        let navigationLink = app.buttons["NavigationLink"]
        XCTAssertTrue(navigationLink.waitForExistence(timeout: 1))
        navigationLink.tap()
    }

    private func setApiKey(with app: XCUIApplication) {
        /// Open settings menu
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 1))
        settingsImage.tap()
        /// Open API key alert
        let apiKeyAddEditButton = app.buttons["ApiKeyAddEditButton"]
        XCTAssertTrue(apiKeyAddEditButton.waitForExistence(timeout: 1))
        apiKeyAddEditButton.tap()
        /// Set API key to first match
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.waitForExistence(timeout: 1))
        textField.doubleTap()
        textField.typeText("Test")
        /// Confirm API key
        let apiKeyDoneButton = app.buttons["ApiKeyDoneButton"]
        XCTAssertTrue(apiKeyDoneButton.waitForExistence(timeout: 1))
        apiKeyDoneButton.tap()
    }

    private func setCountry(with app: XCUIApplication) {
        /// Open settings menu
        let settingsImage = app.images["SettingsImage"]
        XCTAssertTrue(settingsImage.waitForExistence(timeout: 1))
        settingsImage.tap()
        /// Open country picker
        let countryPicker = app.buttons["CountryPicker"]
        XCTAssertTrue(countryPicker.waitForExistence(timeout: 1))
        countryPicker.tap()
        /// Set country to first match
        let countryPickerItem = app.buttons["CountryPickerItem"].firstMatch
        XCTAssertTrue(countryPickerItem.waitForExistence(timeout: 1))
        countryPickerItem.tap()
    }
}
