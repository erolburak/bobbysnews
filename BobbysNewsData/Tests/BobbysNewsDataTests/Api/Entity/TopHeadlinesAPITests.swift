//
//  TopHeadlinesAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

struct TopHeadlinesAPITests {
    // MARK: - Methods

    @Test("Check TopHeadlinesAPI initializing!")
    func testTopHeadlinesAPI() {
        // Given
        let topHeadlinesAPI: TopHeadlinesAPI?
        // When
        topHeadlinesAPI = EntityMock.topHeadlinesAPI
        // Then
        #expect(topHeadlinesAPI?.articles?.first?.author == "Test" &&
            topHeadlinesAPI?.articles?.first?.content == "Test" &&
            topHeadlinesAPI?.articles?.first?.publishedAt == .distantPast &&
            topHeadlinesAPI?.articles?.first?.source?.category == "Test" &&
            topHeadlinesAPI?.articles?.first?.source?.country == "en-gb" &&
            topHeadlinesAPI?.articles?.first?.source?.id == "Test" &&
            topHeadlinesAPI?.articles?.first?.source?.language == "Test" &&
            topHeadlinesAPI?.articles?.first?.source?.name == "Test" &&
            topHeadlinesAPI?.articles?.first?.source?.story == "Test" &&
            topHeadlinesAPI?.articles?.first?.source?.url == URL(string: "Test") &&
            topHeadlinesAPI?.articles?.first?.story == "Test" &&
            topHeadlinesAPI?.articles?.first?.title == "Test" &&
            topHeadlinesAPI?.articles?.first?.url == URL(string: "Test") &&
            topHeadlinesAPI?.articles?.first?.urlToImage == URL(string: "Test"),
            "TopHeadlinesAPI initializing failed!")
    }
}
