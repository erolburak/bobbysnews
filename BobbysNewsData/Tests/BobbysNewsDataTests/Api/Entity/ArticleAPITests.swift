//
//  ArticleAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

@Suite("ArticleAPI tests")
struct ArticleAPITests {
    // MARK: - Methods

    @Test("Check AticleAPI initializing!")
    func testAticleAPI() {
        // Given
        let articleAPI: ArticleAPI?
        // When
        articleAPI = EntityMock.articleAPI
        // Then
        #expect(articleAPI?.author == "Test" &&
            articleAPI?.content == "Test" &&
            articleAPI?.publishedAt == .distantPast &&
            articleAPI?.source?.category == "Test" &&
            articleAPI?.source?.country == "uk" &&
            articleAPI?.source?.id == "Test" &&
            articleAPI?.source?.language == "Test" &&
            articleAPI?.source?.name == "Test" &&
            articleAPI?.source?.story == "Test" &&
            articleAPI?.source?.url == URL(string: "Test") &&
            articleAPI?.story == "Test" &&
            articleAPI?.title == "Test" &&
            articleAPI?.url == URL(string: "Test") &&
            articleAPI?.urlToImage == URL(string: "Test"),
            "AticleAPI initializing failed!")
    }
}
