//
//  ContentViewTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class ContentViewTests: XCTestCase {

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		continueAfterFailure = false
	}

	// MARK: - Actions

	/// Test navigation link item to open detail view
	func testNavigationLinkItem() {
		let app = XCUIApplication()
		app.launch()
		let navigationLink = app.buttons["NavigationLinkItem"]
		XCTAssertTrue(navigationLink.waitForExistence(timeout: 5))
		navigationLink.tap()
	}

	/// Test settings button to open settings menu
	func testSettingsButton() {
		let app = XCUIApplication()
		app.launch()
		let settingsImage = app.navigationBars[Locale.current.language.languageCode == "en" ? "Top headlines" : "Schlagzeilen"].images["SettingsImage"]
		XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
		settingsImage.tap()
	}

	/// Test country picker item to change country while first opening settings menu
	func testCountryPickerItem() {
		let app = XCUIApplication()
		app.launch()
		let settingsImage = app.navigationBars[Locale.current.language.languageCode == "en" ? "Top headlines" : "Schlagzeilen"].images["SettingsImage"]
		XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
		settingsImage.tap()
		let countryPicker = app.collectionViews.buttons[Locale.current.language.languageCode == "en" ? "Country selection" : "Länderauswahl"]
		XCTAssertTrue(countryPicker.waitForExistence(timeout: 5))
		countryPicker.tap()
		let countryPickerItemDE = app.buttons["CountryPickerItem" + "de"]
		XCTAssertTrue(countryPickerItemDE.waitForExistence(timeout: 5))
		countryPickerItemDE.tap()
	}

	/// Test api key picker item to change api key while first opening settings menu
	func testApiKeyPickerItem() {
		let app = XCUIApplication()
		app.launch()
		let settingsImage = app.navigationBars[Locale.current.language.languageCode == "en" ? "Top headlines" : "Schlagzeilen"].images["SettingsImage"]
		XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
		settingsImage.tap()
		let apiKeyPicker = app.collectionViews.buttons[Locale.current.language.languageCode == "en" ? "API key selection" : "API-Schlüsselauswahl"]
		XCTAssertTrue(apiKeyPicker.waitForExistence(timeout: 5))
		apiKeyPicker.tap()
		let apiKeyPickerItem2 = app.buttons["ApiKeyPickerItem2"]
		XCTAssertTrue(apiKeyPickerItem2.waitForExistence(timeout: 5))
		apiKeyPickerItem2.tap()
	}

	/// Test reset and confirm reset while first opening settings view
	func testResetButton() {
		let app = XCUIApplication()
		app.launch()
		let settingsImage = app.navigationBars[Locale.current.language.languageCode == "en" ? "Top headlines" : "Schlagzeilen"].images["SettingsImage"]
		XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
		settingsImage.tap()
		let resetButton = app.buttons["ResetButton"]
		XCTAssertTrue(resetButton.waitForExistence(timeout: 5))
		resetButton.tap()
		let resetConfirmationButton = app.buttons["ResetConfirmationButton"]
		XCTAssertTrue(resetConfirmationButton.waitForExistence(timeout: 5))
	}
}
