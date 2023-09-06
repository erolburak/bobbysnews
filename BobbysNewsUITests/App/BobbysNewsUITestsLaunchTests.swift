//
//  BobbysNewsUITestsLaunchTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class BobbysNewsUITestsLaunchTests: XCTestCase {

	// MARK: - Life Cycle

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

	// MARK: - Actions

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
		let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
