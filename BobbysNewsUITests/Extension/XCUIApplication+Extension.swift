//
//  XCUIApplication+Extension.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 13.09.23.
//

import XCTest

extension XCUIApplication {

	// MARK: - Properties

	/// Identifies if limited request alert is visible
	var isLimitedRequestAlertVisible: Bool {
		self.alerts[Locale.current.language.languageCode == "en" ? "Limited requests" : ""].waitForExistence(timeout: 5)
	}
}
