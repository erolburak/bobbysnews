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
    func article() {
        // Given
        var entity = EntityMock()
        let articleDB = entity.articleDB
        // When
        let article = Article(from: articleDB)
        // Then
        #expect(article.category == "Test" &&
            article.content == "Test" &&
            article.contentTranslated == nil &&
            article.image == URL(string: "Test") &&
            article.publishedAt == .distantPast &&
            !article.showTranslations &&
            article.source?.name == "Test" &&
            article.source?.url == URL(string: "Test") &&
            article.story == "Test" &&
            article.title == "Test" &&
            article.titleTranslated == nil &&
            article.url == URL(string: "Test"),
            "ArticleExtension Article initializing failed!")
    }
}
