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
    func aticleAPI() {
        // Given
        let articleAPI: ArticleAPI?
        // When
        articleAPI = EntityMock.articleAPI
        // Then
        #expect(articleAPI?.content == "Test" &&
            articleAPI?.image == URL(string: "Test") &&
            articleAPI?.publishedAt == .distantPast &&
            articleAPI?.source?.name == "Test" &&
            articleAPI?.source?.url == URL(string: "Test") &&
            articleAPI?.story == "Test" &&
            articleAPI?.title == "Test" &&
            articleAPI?.url == URL(string: "Test"),
            "AticleAPI initializing failed!")
    }
}
