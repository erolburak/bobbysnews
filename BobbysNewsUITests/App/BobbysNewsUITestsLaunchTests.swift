//
//  BobbysNewsUITestsLaunchTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class BobbysNewsUITestsLaunchTests: XCTestCase {
    // MARK: - Methods

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        /// Set launch arguments to `-Testing`
        app.launchArguments = ["–Testing"]
        /// Launch app
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
