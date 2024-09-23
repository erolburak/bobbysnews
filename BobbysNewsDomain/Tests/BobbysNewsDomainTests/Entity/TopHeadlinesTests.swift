//
//  TopHeadlinesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

struct TopHeadlinesTests {
    // MARK: - Methods

    @Test("Check TopHeadlines initializing!")
    func testTopHeadlines() {
        // Given
        let topHeadlines: TopHeadlines?
        // When
        topHeadlines = EntityMock.topHeadlines
        // Then
        #expect(topHeadlines?.articles?.first?.author == "Test" &&
            topHeadlines?.articles?.first?.content == "Test" &&
            topHeadlines?.articles?.first?.publishedAt == .distantPast &&
            topHeadlines?.articles?.first?.source?.category == "Test" &&
            topHeadlines?.articles?.first?.source?.country == "uk" &&
            topHeadlines?.articles?.first?.source?.id == "Test" &&
            topHeadlines?.articles?.first?.source?.language == "Test" &&
            topHeadlines?.articles?.first?.source?.name == "Test" &&
            topHeadlines?.articles?.first?.source?.story == "Test" &&
            topHeadlines?.articles?.first?.source?.url == URL(string: "Test") &&
            topHeadlines?.articles?.first?.story == "Test" &&
            topHeadlines?.articles?.first?.title == "Test" &&
            topHeadlines?.articles?.first?.url == URL(string: "Test") &&
            topHeadlines?.articles?.first?.urlToImage == URL(string: "Test"),
            "TopHeadlines initializing failed!")
    }
}
