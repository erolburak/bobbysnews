//
//  DetailViewTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class DetailViewTests: XCTestCase {

	// MARK: - Actions

	override func setUpWithError() throws {
		continueAfterFailure = false
	}

	/// Test share link to open share view steps:
	/// 1) Close settings tip
	/// 2) Open detail view
	/// 3) Press share
	@MainActor
	func testShareLink() {
		let app = XCUIApplication()
		app.launch()
		app.closeSettingsTip()
		if !app.isLimitedRequestAlertVisible {
			let navigationLink = app.scrollViews.otherElements.buttons["NavigationLinkItem"]
			if navigationLink.waitForExistence(timeout: 5) {
				navigationLink.tap()
				let shareLink = app.buttons["ShareLink"]
				XCTAssertTrue(shareLink.waitForExistence(timeout: 5))
				shareLink.tap()
			}
		}
	}

	/// Test read button to open web view steps:
	/// 1) Close settings tip
	/// 2) Open detail view
	/// 3) Press read
	@MainActor
	func testReadButton() {
		let app = XCUIApplication()
		app.launch()
		app.closeSettingsTip()
		if !app.isLimitedRequestAlertVisible {
			let navigationLink = app.scrollViews.otherElements.buttons["NavigationLinkItem"]
			if navigationLink.waitForExistence(timeout: 5) {
				navigationLink.tap()
				let readButton = app.buttons["ReadButton"]
				XCTAssertTrue(readButton.waitForExistence(timeout: 5))
				readButton.tap()
			}
		}
	}

	/// Test close button of web view steps:
	/// 1) Close settings tip
	/// 2) Open detail view
	/// 3) Press read
	/// 4) Close web view
	@MainActor
	func testCloseButton() {
		let app = XCUIApplication()
		app.launch()
		app.closeSettingsTip()
		if !app.isLimitedRequestAlertVisible {
			let navigationLink = app.scrollViews.otherElements.buttons["NavigationLinkItem"]
			if navigationLink.waitForExistence(timeout: 5) {
				navigationLink.tap()
				let readButton = app.buttons["ReadButton"]
				XCTAssertTrue(readButton.waitForExistence(timeout: 5))
				readButton.tap()
				let closeButton = app.buttons["CloseButton"]
				XCTAssertTrue(closeButton.waitForExistence(timeout: 5))
				closeButton.tap()
			}
		}
	}
}
