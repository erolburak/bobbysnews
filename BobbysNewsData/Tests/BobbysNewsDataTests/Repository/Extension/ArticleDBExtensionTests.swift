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

	@Test("Check ArticleDB initializing!")
	func testArticleDB() {
		// Given
		let articleAPI = EntityMock.articleAPI
		// When
		let articleDB = ArticleDB(from: articleAPI,
								  country: "Test")
		// Then
		#expect(articleDB.author == articleAPI.author &&
				articleDB.content == articleAPI.content &&
				articleDB.publishedAt == articleAPI.publishedAt &&
				articleDB.source?.category == articleAPI.source?.category &&
				articleDB.source?.country == articleAPI.source?.country &&
				articleDB.source?.id == articleAPI.source?.id &&
				articleDB.source?.language == articleAPI.source?.language &&
				articleDB.source?.name == articleAPI.source?.name &&
				articleDB.source?.story == articleAPI.source?.story &&
				articleDB.source?.url == articleAPI.source?.url &&
				articleDB.story == articleAPI.story &&
				articleDB.title == articleAPI.title &&
				articleDB.url == articleAPI.url &&
				articleDB.urlToImage == articleAPI.urlToImage,
				"ArticleDB initializing failed!")
	}
}
