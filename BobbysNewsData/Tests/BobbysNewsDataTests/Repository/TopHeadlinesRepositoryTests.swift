//
//  TopHeadlinesRepositoryTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Testing

@Suite("TopHeadlinesRepository tests")
struct TopHeadlinesRepositoryTests {
    // MARK: - Private Properties

    private let sut = TopHeadlinesRepositoryMock()

    // MARK: - Methods

    @Test("Check TopHeadlinesRepository delete!")
    func delete() {
        #expect(throws: Never.self,
                "TopHeadlinesRepository delete failed!")
        {
            sut.delete()
        }
    }

    @Test("Check TopHeadlinesRepository fetch!")
    func fetch() {
        #expect(throws: Never.self,
                "TopHeadlinesRepository fetch failed!")
        {
            try sut.fetch(apiKey: "Test",
                          category: "Test",
                          country: "Test")
        }
    }

    @Test("Check TopHeadlinesRepository read!")
    func read() {
        // Given
        var topHeadlines: [ArticleDB]?
        // When
        topHeadlines = sut.read(category: "Test",
                                country: "Test")
        // Then
        #expect(topHeadlines?.count == 1,
                "TopHeadlinesRepository read failed!")
    }
}
