//
//  ContentViewTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class ContentViewTests: XCTestCase {

	// MARK: - Actions

	override func setUpWithError() throws {
		continueAfterFailure = false
	}

	/// Test navigation link item to open detail view steps:
	/// 1) Close settings tip
	/// 2) Open detail view
	@MainActor
	func testNavigationLinkItem() {
		let app = XCUIApplication()
		app.launch()
		app.closeSettingsTip()
		if !app.isLimitedRequestAlertVisible {
			let navigationLink = app.buttons["NavigationLinkItem"]
			XCTAssertTrue(navigationLink.waitForExistence(timeout: 5))
			navigationLink.tap()
		}
	}

	/// Test settings button to open settings menu steps:
	/// 1) Close settings tip
	/// 2) Open settings menu
	@MainActor
	func testSettingsButton() {
		let app = XCUIApplication()
		app.launch()
		app.closeSettingsTip()
		if !app.isLimitedRequestAlertVisible {
			let settingsImage = app.navigationBars["Top headlines"].images["SettingsImage"]
			XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
			settingsImage.tap()
		}
	}

	/// Test country picker item to change country steps:
	/// 1) Close settings tip
	/// 2) Open settings menu
	/// 3) Open country picker
	/// 4) Set selected country to DE
	@MainActor
	func testCountryPickerItem() {
		let app = XCUIApplication()
		app.launch()
		app.closeSettingsTip()
		if !app.isLimitedRequestAlertVisible {
			let settingsImage = app.navigationBars["Top headlines"].images["SettingsImage"]
			XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
			settingsImage.tap()
			let countryPicker = app.collectionViews.buttons["Country selection"]
			XCTAssertTrue(countryPicker.waitForExistence(timeout: 5))
			countryPicker.tap()
			let countryPickerItemDE = app.buttons["CountryPickerItem" + "de"]
			XCTAssertTrue(countryPickerItemDE.waitForExistence(timeout: 5))
			countryPickerItemDE.tap()
		}
	}

	/// Test api key picker item to change api key steps:
	/// 1) Close settings tip
	/// 2) Open settings menu
	/// 3) Open api key picker
	/// 4) Set selected api key to 2
	@MainActor
	func testApiKeyPickerItem() {
		let app = XCUIApplication()
		app.launch()
		app.closeSettingsTip()
		if !app.isLimitedRequestAlertVisible {
			let settingsImage = app.navigationBars["Top headlines"].images["SettingsImage"]
			XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
			settingsImage.tap()
			let apiKeyPicker = app.collectionViews.buttons["API key selection"]
			XCTAssertTrue(apiKeyPicker.waitForExistence(timeout: 5))
			apiKeyPicker.tap()
			let apiKeyPickerItem2 = app.buttons["ApiKeyPickerItem2"]
			XCTAssertTrue(apiKeyPickerItem2.waitForExistence(timeout: 5))
			apiKeyPickerItem2.tap()
		}
	}

	/// Test reset and confirm reset steps:
	/// 1) Close settings tip
	/// 2) Open settings menu
	/// 3) Press reset
	/// 4) Check if `ResetConfirmationDialogButton` exists
	@MainActor
	func testResetButton() {
		let app = XCUIApplication()
		app.launch()
		app.closeSettingsTip()
		if !app.isLimitedRequestAlertVisible {
			let settingsImage = app.navigationBars["Top headlines"].images["SettingsImage"]
			XCTAssertTrue(settingsImage.waitForExistence(timeout: 5))
			settingsImage.tap()
			let resetButton = app.buttons["ResetButton"]
			XCTAssertTrue(resetButton.waitForExistence(timeout: 5))
			resetButton.tap()
			let resetConfirmationDialogButton = app.buttons["ResetConfirmationDialogButton"]
			XCTAssertTrue(resetConfirmationDialogButton.waitForExistence(timeout: 5))
		}
	}
}
