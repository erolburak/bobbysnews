//
//  DateExtensionTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

import Foundation
import Testing

@Suite("DateExtension tests")
struct DateExtensionTests {
    // MARK: - Methods

    @Test("Check DateExtension toRelative with now!")
    func toRelativeWithNow() {
        // Given
        let date = Date.now
        let relative = "Today"
        // When
        let relativeDate = date.toRelative
        // Then
        #expect(
            relativeDate.contains(relative),
            "DateExtension toRelative with now failed!"
        )
    }

    @Test("Check DateExtension toRelative with yesterday!")
    func toRelativeWithYesterday() {
        // Given
        let date =
            Calendar.current.date(
                byAdding: DateComponents(day: -1),
                to: .now
            ) ?? .now
        let relative = "Yesterday"
        // When
        let relativeDate = date.toRelative
        // Then
        #expect(
            relativeDate.contains(relative),
            "DateExtension toRelative with yesterday failed!"
        )
    }
}
