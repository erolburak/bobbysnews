//
//  ArticleDBExtensionTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsData
import Testing

struct ArticleDBExtensionTests {

	// MARK: - Actions

	@Test("Check initializing ArticleDB!")
	func testArticleDB() {
		// Given
		let articleAPI = EntityMock.articleAPI
		// When
		let articleDB = ArticleDB(from: articleAPI,
								  country: "Test")
		// Then
		#expect(articleDB.author == articleAPI.author,
				"Initializing ArticleDB articleDB.author failed!")
		#expect(articleDB.content == articleAPI.content,
				"Initializing ArticleDB articleDB.content failed!")
		#expect(articleDB.publishedAt == articleAPI.publishedAt,
				"Initializing ArticleDB articleDB.publishedAt failed!")
		#expect(articleDB.source?.category == articleAPI.source?.category,
				"Initializing ArticleDB articleDB.source?.category failed!")
		#expect(articleDB.source?.country == articleAPI.source?.country,
				"Initializing ArticleDB articleDB.source?.country failed!")
		#expect(articleDB.source?.id == articleAPI.source?.id,
				"Initializing ArticleDB articleDB.source?.id failed!")
		#expect(articleDB.source?.language == articleAPI.source?.language,
				"Initializing ArticleDB articleDB.source?.language failed!")
		#expect(articleDB.source?.name == articleAPI.source?.name,
				"Initializing ArticleDB articleDB.source?.name failed!")
		#expect(articleDB.source?.story == articleAPI.source?.story,
				"Initializing ArticleDB articleDB.source?.story failed!")
		#expect(articleDB.source?.url == articleAPI.source?.url,
				"Initializing ArticleDB articleDB.source?.url failed!")
		#expect(articleDB.story == articleAPI.story,
				"Initializing ArticleDB articleDB.story failed!")
		#expect(articleDB.title == articleAPI.title,
				"Initializing ArticleDB articleDB.title failed!")
		#expect(articleDB.url == articleAPI.url,
				"Initializing ArticleDB articleDB.url failed!")
		#expect(articleDB.urlToImage == articleAPI.urlToImage,
				"Initializing ArticleDB articleDB.urlToImage failed!")
	}
}
