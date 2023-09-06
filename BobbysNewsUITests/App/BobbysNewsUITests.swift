//
//  BobbysNewsUITests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class BobbysNewsUITests: XCTestCase {

	// MARK: - Life Cycle

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

	// MARK: - Actions

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
