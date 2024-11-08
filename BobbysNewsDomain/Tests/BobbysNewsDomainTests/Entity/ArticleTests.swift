//
//  ArticleTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

@Suite("Article tests")
struct ArticleTests {
    // MARK: - Methods

    @Test("Check Aticle initializing!")
    func testArticle() {
        // Given
        let article: Article?
        // When
        article = EntityMock.topHeadlines.articles?.first
        // Then
        #expect(article?.author == "Test" &&
            article?.content == "Test" &&
            article?.contentTranslated == nil &&
            article?.publishedAt == .distantPast &&
            !article?.showTranslations &&
            article?.source?.category == "Test" &&
            article?.source?.country == "uk" &&
            article?.source?.id == "Test" &&
            article?.source?.language == "Test" &&
            article?.source?.name == "Test" &&
            article?.source?.story == "Test" &&
            article?.source?.url == URL(string: "Test") &&
            article?.story == "Test" &&
            article?.title == "Test" &&
            article?.titleTranslated == nil &&
            article?.url == URL(string: "Test") &&
            article?.urlToImage == URL(string: "Test"),
            "Article initializing failed!")
    }
}
