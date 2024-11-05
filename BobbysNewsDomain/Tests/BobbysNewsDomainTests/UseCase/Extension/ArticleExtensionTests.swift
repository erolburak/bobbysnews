//
//  ArticleExtensionTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

@Suite("ArticleExtension tests")
struct ArticleExtensionTests {
    // MARK: - Methods

    @Test("Check ArticleExtension Article initializing!")
    func testArticle() {
        // Given
        var entity = EntityMock()
        let articleDB = entity.articleDB
        // When
        let article = Article(from: articleDB)
        // Then
        #expect(article.author == "Test" &&
            article.content == "Test" &&
            article.contentTranslated == nil &&
            article.publishedAt == .distantPast &&
            article.source?.category == "Test" &&
            article.source?.country == "uk" &&
            article.source?.id == "Test" &&
            article.source?.language == "Test" &&
            article.source?.name == "Test" &&
            article.source?.story == "Test" &&
            article.source?.url == URL(string: "Test") &&
            article.story == "Test" &&
            article.title == "Test" &&
            article.titleTranslated == nil &&
            article.url == URL(string: "Test") &&
            article.urlToImage == URL(string: "Test"),
            "ArticleExtension Article initializing failed!")
    }
}
