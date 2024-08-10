//
//  SourceAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

struct SourceAPITests {

	// MARK: - Actions

	@Test("Check initializing SourceAPI!")
	func testSourceAPI() {
		// Given
		let sourceAPI: SourceAPI?
		// When
		sourceAPI = EntityMock.sourceAPI
		// Then
		#expect(sourceAPI?.category == "Test",
				"Initializing AticleAPI sourceAPI?.category failed!")
		#expect(sourceAPI?.country == "Test",
				"Initializing AticleAPI sourceAPI?.country failed!")
		#expect(sourceAPI?.id == "Test",
				"Initializing AticleAPI sourceAPI?.id failed!")
		#expect(sourceAPI?.language == "Test",
				"Initializing AticleAPI sourceAPI?.language failed!")
		#expect(sourceAPI?.name == "Test",
				"Initializing AticleAPI sourceAPI?.name failed!")
		#expect(sourceAPI?.story == "Test",
				"Initializing AticleAPI sourceAPI?.story failed!")
		#expect(sourceAPI?.url == URL(string: "Test"),
				"Initializing AticleAPI sourceAPI?.url failed!")
	}
}
