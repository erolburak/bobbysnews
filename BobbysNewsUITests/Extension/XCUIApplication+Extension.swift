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
        /// Set selected country if needed
        let emptySelectedCountryMessage = app.staticTexts["EmptySelectedCountryMessage"]
        if emptySelectedCountryMessage.waitForExistence(timeout: 5) {
            /// Open settings menu
            let settingsImage = app.images["SettingsImage"]
            XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
            settingsImage.tap()
            /// Open country picker
            let countryPicker = app.buttons["Country selection"]
            XCTAssertTrue(countryPicker.waitForExistence(timeout: 5))
            countryPicker.tap()
            /// Set selected country to `uk`
            let countryPickerItem = app.buttons["CountryPickerItem" + "uk"]
            XCTAssertTrue(countryPickerItem.waitForExistence(timeout: 5))
            countryPickerItem.tap()
        }
        return app
    }

    func openDetailView(with app: XCUIApplication) {
        /// Open detail view
        let navigationLink = app.buttons["NavigationLink"]
        XCTAssertTrue(navigationLink.waitForExistence(timeout: 5))
        navigationLink.tap()
    }
}
