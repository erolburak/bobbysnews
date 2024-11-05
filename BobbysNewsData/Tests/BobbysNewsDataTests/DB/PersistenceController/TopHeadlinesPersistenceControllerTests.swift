//
//  TopHeadlinesPersistenceControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsData
import Testing

@Suite("TopHeadlinesPersistenceController tests")
struct TopHeadlinesPersistenceControllerTests {
    // MARK: - Private Properties

    private let sut = TopHeadlinesPersistenceControllerMock()

    // MARK: - Methods

    @Test("Check TopHeadlinesPersistenceController delete!")
    func testDelete() {
        #expect(throws: Never.self,
                "TopHeadlinesPersistenceController delete failed!")
        {
            sut.delete()
        }
    }

    @Test("Check TopHeadlinesPersistenceController read!")
    func testRead() {
        // Given
        var topHeadlines: [ArticleDB]?
        // When
        topHeadlines = sut.read(country: "uk")
        // Then
        #expect(topHeadlines?.count == 1,
                "TopHeadlinesPersistenceController read failed!")
    }

    @Test("Check TopHeadlinesPersistenceController save!")
    func testSave() {
        #expect(throws: Never.self,
                "TopHeadlinesPersistenceController save failed!")
        {
            sut.save(country: "uk",
                     topHeadlinesAPI: EntityMock.topHeadlinesAPI)
        }
    }
}
