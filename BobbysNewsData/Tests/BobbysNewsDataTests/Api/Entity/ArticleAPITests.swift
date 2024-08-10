//
//  ArticleAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

struct ArticleAPITests {

	// MARK: - Actions

	@Test("Check initializing AticleAPI!")
	func testAticleAPI() {
		// Given
		let articleAPI: ArticleAPI?
		// When
		articleAPI = EntityMock.articleAPI
		// Then
		#expect(articleAPI?.author == "Test",
				"Initializing AticleAPI articleAPI?.author failed!")
		#expect(articleAPI?.content == "Test",
				"Initializing AticleAPI articleAPI?.content failed!")
		#expect(articleAPI?.publishedAt == .distantPast,
				"Initializing AticleAPI articleAPI?.publishedAt failed!")
		#expect(articleAPI?.source?.category == "Test",
				"Initializing AticleAPI articleAPI?.source?.category failed!")
		#expect(articleAPI?.source?.country == "Test",
				"Initializing AticleAPI articleAPI?.source?.country failed!")
		#expect(articleAPI?.source?.id == "Test",
				"Initializing AticleAPI articleAPI?.source?.id failed!")
		#expect(articleAPI?.source?.language == "Test",
				"Initializing AticleAPI articleAPI?.source?.language failed!")
		#expect(articleAPI?.source?.name == "Test",
				"Initializing AticleAPI articleAPI?.source?.name failed!")
		#expect(articleAPI?.source?.story == "Test",
				"Initializing AticleAPI articleAPI?.source?.story failed!")
		#expect(articleAPI?.source?.url == URL(string: "Test"),
				"Initializing AticleAPI articleAPI?.source?.url failed!")
		#expect(articleAPI?.story == "Test",
				"Initializing AticleAPI articleAPI?.story failed!")
		#expect(articleAPI?.title == "Test",
				"Initializing AticleAPI articleAPI?.title failed!")
		#expect(articleAPI?.url == URL(string: "Test"),
				"Initializing AticleAPI articleAPI?.url failed!")
		#expect(articleAPI?.urlToImage == URL(string: "Test"),
				"Initializing AticleAPI articleAPI?.urlToImage failed!")
	}
}
