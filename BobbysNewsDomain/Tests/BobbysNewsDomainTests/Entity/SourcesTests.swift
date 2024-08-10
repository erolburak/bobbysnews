//
//  SourcesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

struct SourcesTests {

	// MARK: - Actions

	@Test("Check initializing Sources!")
	func testSources() {
		// Given
		let sources: Sources?
		// When
		sources = EntityMock.sources
		// Then
		#expect(sources?.sources?.first?.category == "Test",
				"Initializing Sources sources?.sources?.first?.category failed!")
		#expect(sources?.sources?.first?.country == "Test",
				"Initializing Sources sources?.sources?.first?.country failed!")
		#expect(sources?.sources?.first?.id == "Test",
				"Initializing Sources sources?.sources?.first?.id failed!")
		#expect(sources?.sources?.first?.language == "Test",
				"Initializing Sources sources?.sources?.first?.language failed!")
		#expect(sources?.sources?.first?.name == "Test",
				"Initializing Sources sources?.sources?.first?.name failed!")
		#expect(sources?.sources?.first?.story == "Test",
				"Initializing Sources sources?.sources?.first?.story failed!")
		#expect(sources?.sources?.first?.url == URL(string: "Test"),
				"Initializing Sources sources?.sources?.first?.url failed!")
	}
}
