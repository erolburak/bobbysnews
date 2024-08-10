//
//  TopHeadlinesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

struct TopHeadlinesTests {

	// MARK: - Actions

	@Test("Check initializing TopHeadlines!")
	func testTopHeadlines() {
		// Given
		let topHeadlines: TopHeadlines?
		// When
		topHeadlines = EntityMock.topHeadlines
		// Then
		#expect(topHeadlines?.articles?.first?.author == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.author failed!")
		#expect(topHeadlines?.articles?.first?.content == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.content failed!")
		#expect(topHeadlines?.articles?.first?.publishedAt == .distantPast,
				"Initializing TopHeadlines topHeadlines?.articles?.first?.publishedAt failed!")
		#expect(topHeadlines?.articles?.first?.source?.category == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.source?.category failed!")
		#expect(topHeadlines?.articles?.first?.source?.country == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.source?.country failed!")
		#expect(topHeadlines?.articles?.first?.source?.id == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.source?.id failed!")
		#expect(topHeadlines?.articles?.first?.source?.language == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.source?.language failed!")
		#expect(topHeadlines?.articles?.first?.source?.name == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.source?.name failed!")
		#expect(topHeadlines?.articles?.first?.source?.story == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.source?.story failed!")
		#expect(topHeadlines?.articles?.first?.source?.url == URL(string: "Test"),
				"Initializing TopHeadlines topHeadlines?.articles?.first?.source?.url failed!")
		#expect(topHeadlines?.articles?.first?.story == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.story failed!")
		#expect(topHeadlines?.articles?.first?.title == "Test",
				"Initializing TopHeadlines topHeadlines?.articles?.first?.title failed!")
		#expect(topHeadlines?.articles?.first?.url == URL(string: "Test"),
				"Initializing TopHeadlines topHeadlines?.articles?.first?.url failed!")
		#expect(topHeadlines?.articles?.first?.urlToImage == URL(string: "Test"),
				"Initializing TopHeadlines topHeadlines?.articles?.first?.urlToImage failed!")
	}
}
