//
//  TopHeadlinesApiTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class TopHeadlinesApiTests: XCTestCase {
    // MARK: - Actions

    func testTopHeadlinesApi() {
        // Given
        let topHeadlinesApi: TopHeadlinesApi?
        // When
        topHeadlinesApi = TopHeadlinesApi(articles: [ArticleApi(author: "Test",
                                                                content: "Test",
                                                                publishedAt: "2001-02-03T12:34:56Z",
                                                                source: SourceApi(category: "Test",
                                                                                  country: "Test",
                                                                                  id: "Test",
                                                                                  language: "Test",
                                                                                  name: "Test",
                                                                                  story: "Test",
                                                                                  url: URL(string: "Test")),
                                                                story: "Test",
                                                                title: "Test",
                                                                url: URL(string: "Test"),
                                                                urlToImage: URL(string: "Test"))],
                                          status: "Test",
                                          totalResults: 1)
        // Then
        XCTAssertNotNil(topHeadlinesApi)
    }
}
