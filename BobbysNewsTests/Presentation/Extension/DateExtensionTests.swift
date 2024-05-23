//
//  DateExtensionTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class DateExtensionTests: XCTestCase {

	// MARK: - Actions

	func testToRelativeIsToday() {
		// Given
		let date = Date.now
		let relative = "Today"
		// When
		let relativeDate = date.toRelative
		// Then
		XCTAssertTrue(relativeDate.contains(relative))
	}

	func testToRelativeIsYesterday() {
		// Given
		let date = Calendar.current.date(byAdding: DateComponents(day: -1),
										 to: .now)
		let relative = "Yesterday"
		// When
		let relativeDate = date?.toRelative ?? relative
		// Then
		XCTAssertTrue(relativeDate.contains(relative))
	}
}
