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

	@Test("Check DateExtension toRelative with now!")
	func testToRelativeWithNow() {
		// Given
		let date = Date.now
		let relative = "Today"
		// When
		let relativeDate = date.toRelative
		// Then
		#expect(relativeDate.contains(relative),
				"DateExtension toRelative with now failed!")
	}

	@Test("Check DateExtension toRelative with yesterday!")
	func testToRelativeWithYesterday() {
		// Given
		let date = Calendar.current.date(byAdding: DateComponents(day: -1),
										 to: .now) ?? .now
		let relative = "Yesterday"
		// When
		let relativeDate = date.toRelative
		// Then
		#expect(relativeDate.contains(relative),
				"DateExtension toRelative with yesterday failed!")
	}
}
