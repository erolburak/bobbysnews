//
//  TopHeadlinesAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

struct TopHeadlinesAPITests {

	// MARK: - Actions

	@Test("Check initializing TopHeadlinesAPI!")
	func testTopHeadlinesAPI() {
		// Given
		let topHeadlinesAPI: TopHeadlinesAPI?
		// When
		topHeadlinesAPI = EntityMock.topHeadlinesAPI
		// Then
		#expect(topHeadlinesAPI?.articles?.first?.author == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.author failed!")
		#expect(topHeadlinesAPI?.articles?.first?.content == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.content failed!")
		#expect(topHeadlinesAPI?.articles?.first?.publishedAt == .distantPast,
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.publishedAt failed!")
		#expect(topHeadlinesAPI?.articles?.first?.source?.category == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.source?.category failed!")
		#expect(topHeadlinesAPI?.articles?.first?.source?.country == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.source?.country failed!")
		#expect(topHeadlinesAPI?.articles?.first?.source?.id == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.source?.id failed!")
		#expect(topHeadlinesAPI?.articles?.first?.source?.language == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.source?.language failed!")
		#expect(topHeadlinesAPI?.articles?.first?.source?.name == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.source?.name failed!")
		#expect(topHeadlinesAPI?.articles?.first?.source?.story == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.source?.story failed!")
		#expect(topHeadlinesAPI?.articles?.first?.source?.url == URL(string: "Test"),
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.source?.url failed!")
		#expect(topHeadlinesAPI?.articles?.first?.story == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.story failed!")
		#expect(topHeadlinesAPI?.articles?.first?.title == "Test",
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.title failed!")
		#expect(topHeadlinesAPI?.articles?.first?.url == URL(string: "Test"),
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.url failed!")
		#expect(topHeadlinesAPI?.articles?.first?.urlToImage == URL(string: "Test"),
				"Initializing TopHeadlinesAPI topHeadlinesAPI?.articles?.first?.urlToImage failed!")
	}
}
