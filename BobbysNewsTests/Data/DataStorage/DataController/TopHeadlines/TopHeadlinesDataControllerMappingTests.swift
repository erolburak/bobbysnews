//
//  TopHeadlinesDataControllerMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 23.01.24.
//

@testable import BobbysNews
import XCTest

class TopHeadlinesDataControllerMappingTests: XCTestCase {
    // MARK: - Actions

    func testArticle() {
        // Given
        let articleEntity = EntityMock.articleEntity1
        // When
        let article = Article(from: articleEntity)
        // Then
        XCTAssertEqual(article.author, articleEntity.author)
        XCTAssertEqual(article.content, articleEntity.content)
        XCTAssertEqual(article.publishedAt, articleEntity.publishedAt)
        XCTAssertEqual(article.source?.category, articleEntity.source?.category)
        XCTAssertEqual(article.source?.country, articleEntity.source?.country)
        XCTAssertEqual(article.source?.id, articleEntity.source?.id)
        XCTAssertEqual(article.source?.language, articleEntity.source?.language)
        XCTAssertEqual(article.source?.name, articleEntity.source?.name)
        XCTAssertEqual(article.source?.story, articleEntity.source?.story)
        XCTAssertNotNil(article.source?.url)
        XCTAssertEqual(article.story, articleEntity.story)
        XCTAssertEqual(article.title, articleEntity.title)
        XCTAssertNotNil(article.url)
        XCTAssertNotNil(article.urlToImage)
    }

    func testArticleEntity() {
        // Given
        let articleApi = ApiMock.articleApi1
        // When
        let articleEntity = ArticleEntity(from: articleApi,
                                          country: "Test",
                                          in: DataController.shared.backgroundContext)
        // Then
        XCTAssertEqual(articleEntity?.author, articleApi.author)
        XCTAssertEqual(articleEntity?.content, articleApi.content)
        XCTAssertEqual(articleEntity?.publishedAt, articleApi.publishedAt?.toDate)
        XCTAssertEqual(articleEntity?.source?.category, articleApi.source?.category)
        XCTAssertEqual(articleEntity?.source?.country, articleApi.source?.country)
        XCTAssertEqual(articleEntity?.source?.id, articleApi.source?.id)
        XCTAssertEqual(articleEntity?.source?.language, articleApi.source?.language)
        XCTAssertEqual(articleEntity?.source?.name, articleApi.source?.name)
        XCTAssertEqual(articleEntity?.source?.story, articleApi.source?.story)
        XCTAssertEqual(articleEntity?.source?.url, articleApi.source?.url)
        XCTAssertEqual(articleEntity?.story, articleApi.story)
        XCTAssertEqual(articleEntity?.title, articleApi.title)
        XCTAssertNotNil(articleEntity?.url)
        XCTAssertNotNil(articleEntity?.urlToImage)
    }
}
