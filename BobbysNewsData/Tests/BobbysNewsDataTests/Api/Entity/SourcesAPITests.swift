//
//  SourcesAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

struct SourcesAPITests {

	// MARK: - Actions

	@Test("Check initializing SourcesAPI!")
	func testSourcesAPI() {
		// Given
		let sourcesAPI: SourcesAPI?
		// When
		sourcesAPI = EntityMock.sourcesAPI
		// Then
		#expect(sourcesAPI?.sources?.first?.category == "Test",
				"Initializing SourcesAPI sourcesAPI?.sources?.first?.category failed!")
		#expect(sourcesAPI?.sources?.first?.country == "Test",
				"Initializing SourcesAPI sourcesAPI?.sources?.first?.country failed!")
		#expect(sourcesAPI?.sources?.first?.id == "Test",
				"Initializing SourcesAPI sourcesAPI?.sources?.first?.id failed!")
		#expect(sourcesAPI?.sources?.first?.language == "Test",
				"Initializing SourcesAPI sourcesAPI?.sources?.first?.language failed!")
		#expect(sourcesAPI?.sources?.first?.name == "Test",
				"Initializing SourcesAPI sourcesAPI?.sources?.first?.name failed!")
		#expect(sourcesAPI?.sources?.first?.story == "Test",
				"Initializing SourcesAPI sourcesAPI?.sources?.first?.story failed!")
		#expect(sourcesAPI?.sources?.first?.url == URL(string: "Test"),
				"Initializing SourcesAPI sourcesAPI?.sources?.first?.url failed!")
	}
}
