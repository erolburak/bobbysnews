//
//  ArticleExtensionTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

struct ArticleExtensionTests {

	// MARK: - Actions

	@Test("Check initializing Aticle!")
	func testArticle() {
		// Given
		var entity = EntityMock()
		let articleDB = entity.articleDB
		// When
		let article = Article(from: articleDB)
		// Then
		#expect(article.author == "Test",
				"Initializing Article article.author failed!")
		#expect(article.content == "Test",
				"Initializing Article article.content failed!")
		#expect(article.publishedAt == .distantPast,
				"Initializing Article article.publishedAt failed!")
		#expect(article.source?.category == "Test",
				"Initializing Article article.source?.category failed!")
		#expect(article.source?.country == "Test",
				"Initializing Article article.source?.country failed!")
		#expect(article.source?.id == "Test",
				"Initializing Article article.source?.id failed!")
		#expect(article.source?.language == "Test",
				"Initializing Article article.source?.language failed!")
		#expect(article.source?.name == "Test",
				"Initializing Article article.source?.name failed!")
		#expect(article.source?.story == "Test",
				"Initializing Article article.source?.story failed!")
		#expect(article.source?.url == URL(string: "Test"),
				"Initializing Article article.source?.url failed!")
		#expect(article.story == "Test",
				"Initializing Article article.story failed!")
		#expect(article.title == "Test",
				"Initializing Article article.title failed!")
		#expect(article.url == URL(string: "Test"),
				"Initializing Article article.url failed!")
		#expect(article.urlToImage == URL(string: "Test"),
				"Initializing Article article.urlToImage failed!")
	}
}
