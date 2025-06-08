//
//  CategoriesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 07.06.25.
//

@testable import BobbysNewsDomain
import Testing

@Suite("Categories tests")
struct CategoriesTests {
    // MARK: - Methods

    @Test("Check Categories initializing!")
    func categories() {
        for category in EntityMock.categories {
            // Given
            var newCategory: Categories?
            // When
            newCategory = category
            // Then
            #expect(newCategory != nil,
                    "Category initializing failed!")
        }
    }
}
