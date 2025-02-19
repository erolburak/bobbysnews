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
    func testDelete() {
        #expect(throws: Never.self,
                "TopHeadlinesRepository delete failed!")
        {
            sut.delete()
        }
    }

    @Test("Check TopHeadlinesRepository fetch!")
    func testFetch() {
        #expect(throws: Never.self,
                "TopHeadlinesRepository fetch failed!")
        {
            try sut.fetch(apiKey: 1,
                          country: "uk")
        }
    }

    @Test("Check TopHeadlinesRepository read!")
    func testRead() {
        // Given
        var topHeadlines: [ArticleDB]?
        // When
        topHeadlines = sut.read(country: "uk")
        // Then
        #expect(topHeadlines?.count == 1,
                "TopHeadlinesRepository read failed!")
    }
}
