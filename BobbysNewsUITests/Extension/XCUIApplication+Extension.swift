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
        if staticTexts["EmptyApiKeyMessage"].exists {
            setApiKey(with: self)
        }
        /// Set country if needed
        if staticTexts["EmptyCountryMessage"].exists {
            setCountry(with: self)
        }
        return self
    }

    func showApiKeyAddEditView(with app: XCUIApplication) {
        /// Show settings menu
        app.buttons["SettingsMenu"].tap()
        /// Show API key alert
        app.buttons["ApiKeyAddEditButton"].tap()
    }

    func showDetailView(with app: XCUIApplication) {
        /// Show detail view
        app.buttons["ContentListItem"].tap()
    }

    private func setApiKey(with app: XCUIApplication) {
        showApiKeyAddEditView(with: app)
        /// Set API key to `Test`
        let textField = app.textFields.firstMatch
        textField.doubleTap()
        textField.typeText("Test")
        /// Confirm API key
        app.buttons["ApiKeyDoneButton"].firstMatch.tap()
    }

    private func setCountry(with app: XCUIApplication) {
        /// Show settings menu
        app.buttons["SettingsMenu"].tap()
        /// Show country picker
        app.buttons["CountryPicker"].tap()
        /// Set country to `Afghanistan`
        app.buttons["Afghanistan"].tap()
    }
}
