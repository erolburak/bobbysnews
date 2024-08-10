//
//  DateExtensionTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

import Foundation
import Testing

struct DateExtensionTests {

	// MARK: - Actions

	@Test("Check date to relative formatter with today!")
	func testToRelativeIsToday() {
		// Given
		let date = Date.now
		let relative = "Today"
		// When
		let relativeDate = date.toRelative
		// Then
		#expect(relativeDate.contains(relative),
				"Date to relative formatter with today failed!")
	}

	@Test("Check date to relative formatter with yesterday!")
	func testToRelativeIsYesterday() {
		// Given
		let date = Calendar.current.date(byAdding: DateComponents(day: -1),
										 to: .now)
		let relative = "Yesterday"
		// When
		let relativeDate = date?.toRelative ?? relative
		// Then
		#expect(relativeDate.contains(relative),
				"Date to relative formatter with yesterday failed!")
	}
}
