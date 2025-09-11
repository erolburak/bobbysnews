//
//  XCUIElement+Extension.swift
//  BobbysNewsUITests
//
//  Created by Burak Erol on 11.09.25.
//

import XCTest

extension XCUIElement {
    // MARK: - Methods

    @discardableResult
    func waitForExistence() -> XCUIElement {
        /// Check if `XCUIElement` exists
        let exists = self.waitForExistence(timeout: 5)
        XCTAssertTrue(exists)
        return self
    }

    func waitForNonExistence() {
        /// Check if `XCUIElement` not exists
        let notExists = self.waitForNonExistence(timeout: 5)
        XCTAssertTrue(notExists)
    }
}
