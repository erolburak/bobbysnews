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
        if staticTexts[Accessibility.emptyApiKey.id].exists {
            setApiKey(with: self)
        }
        /// Set country if needed
        if staticTexts[Accessibility.emptyCountry.id].exists {
            setCountry(with: self)
        }
        return self
    }

    func showApiKeyAddEditView(with app: XCUIApplication) {
        /// Show settings menu
        app.buttons[Accessibility.settingsMenu.id].waitForExistence().tap()
        /// Show API key alert
        app.buttons[Accessibility.apiKeyAddEditButton.id].waitForExistence().tap()
    }

    func showDetailView(with app: XCUIApplication) {
        /// Show detail view
        app.buttons[Accessibility.contentListItem.id].waitForExistence().tap()
    }

    private func setApiKey(with app: XCUIApplication) {
        showApiKeyAddEditView(with: app)
        /// Set API key to `Test`
        let textField = app.textFields.firstMatch.waitForExistence()
        textField.doubleTap()
        textField.typeText("Test")
        /// Confirm selected API key
        app.buttons[Accessibility.apiKeyAlertConfirmButton.id].firstMatch.waitForExistence().tap()
        /// Check if `EmptyApiKey` not exists
        app.staticTexts[Accessibility.emptyApiKey.id].waitForNonExistence()
    }

    private func setCountry(with app: XCUIApplication) {
        /// Show settings menu
        app.buttons[Accessibility.settingsMenu.id].waitForExistence().tap()
        /// Show country picker
        app.buttons[Accessibility.countryPicker.id].waitForExistence().tap()
        /// Set country to `Afghanistan`
        app.buttons["Afghanistan"].waitForExistence().tap()
        /// Check if `EmptyCountry` not exists
        app.staticTexts[Accessibility.emptyCountry.id].waitForNonExistence()
    }
}
