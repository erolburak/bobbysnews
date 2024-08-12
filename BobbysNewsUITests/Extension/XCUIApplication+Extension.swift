//
//  XCUIApplication+Extension.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 13.09.23.
//

import XCTest

extension XCUIApplication {

	// MARK: - Properties

	/// Detects if limited request alert is visible
	var isLimitedRequestAlertVisible: Bool {
		alerts["Limited requests"].waitForExistence(timeout: 5)
	}

	// MARK: - Actions

	/// Detects if settings tip is visible and closes it
	func closeSettingsTip() {
		let closeSettingsTipButton = popovers.buttons["Close"]
		if closeSettingsTipButton.waitForExistence(timeout: 5) {
			closeSettingsTipButton.tap()
		}
	}
}
