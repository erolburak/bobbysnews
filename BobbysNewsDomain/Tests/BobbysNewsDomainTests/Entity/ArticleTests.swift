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
    func article() {
        // Given
        let article: Article?
        // When
        article = EntityMock.topHeadlines.articles?.first
        // Then
        #expect(article?.category == "Test" &&
            article?.content == "Test" &&
            article?.contentTranslated == nil &&
            article?.country == "Test" &&
            article?.image == URL(string: "Test") &&
            article?.publishedAt == .distantPast &&
            article?.showTranslations == false &&
            article?.source?.name == "Test" &&
            article?.source?.url == URL(string: "Test") &&
            article?.story == "Test" &&
            article?.title == "Test" &&
            article?.titleTranslated == nil &&
            article?.url == URL(string: "Test"),
            "Article initializing failed!")
    }
}
