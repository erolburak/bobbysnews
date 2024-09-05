//
//  XCUIApplication+Extension.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 13.09.23.
//

import XCTest

extension XCUIApplication {
    // MARK: - Methods

    /// Launch app steps:
    /// 1) Set launch arguments to -uitesting
    /// 2) Close settings tip
    /// 2) Open country picker
    /// 3) Set selected country to us
    func appLaunch() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["–uitesting"]
        app.launch()
        let closeSettingsTipButton = popovers.buttons["Close"]
        if closeSettingsTipButton.waitForExistence(timeout: 5) {
            closeSettingsTipButton.tap()
        }
        let emptySelectedCountryMessage = app.staticTexts["EmptySelectedCountryMessage"]
        if emptySelectedCountryMessage.waitForExistence(timeout: 5) {
            let settingsImage = app.images["SettingsImage"]
            XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
            settingsImage.tap()
            let countryPicker = app.buttons["Country selection"]
            XCTAssertTrue(countryPicker.waitForExistence(timeout: 5))
            countryPicker.tap()
            let countryPickerItemDE = app.buttons["CountryPickerItem" + "en-gb"]
            XCTAssertTrue(countryPickerItemDE.waitForExistence(timeout: 5))
            countryPickerItemDE.tap()
        }
        return app
    }
}
