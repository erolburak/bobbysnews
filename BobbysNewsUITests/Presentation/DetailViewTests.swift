//
//  DetailViewTests.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 31.08.23.
//

import XCTest

final class DetailViewTests: XCTestCase {
    // MARK: - Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testDetailView() {
        /// Launch app
        let app = XCUIApplication().appLaunch()
        app.showDetailView(with: app)
        showCloseWebView(with: app)
        showShareView(with: app)
    }

    @MainActor
    private func showCloseWebView(with app: XCUIApplication) {
        /// Show web view
        app.buttons["ShowWebViewButton"].tap()
        /// Close web view
        app.buttons["CloseWebViewButton"].tap()
    }

    @MainActor
    private func showShareView(with app: XCUIApplication) {
        /// Show share view
        app.buttons["ShareLink"].tap()
    }
}
