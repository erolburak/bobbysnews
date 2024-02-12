//
//  BobbysNewsUITests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class BobbysNewsUITests: XCTestCase {

	// MARK: - Actions

	override func setUpWithError() throws {
		continueAfterFailure = false
	}

	@MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
