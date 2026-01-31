//
//  AccessibilityTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 29.01.26.
//

import Testing

@Suite("Accessibility tests")
struct AccessibilityTests {
    // MARK: - Methods

    @Test("Check AccessibilityTests initializing!")
    func accessibility() {
        for accessibility in Accessibility.allCases {
            // Given
            var newAccessibility: Accessibility?
            // When
            newAccessibility = accessibility
            // Then
            #expect(
                newAccessibility != nil,
                "Accessibility initializing failed!"
            )
        }
    }
}
