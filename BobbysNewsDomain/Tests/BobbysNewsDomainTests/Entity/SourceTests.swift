//
//  SourceTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

struct SourceTests {

	// MARK: - Actions

	@Test("Check initializing Source!")
	func testSource() {
		// Given
		let source: Source?
		// When
		source = EntityMock.source
		// Then
		#expect(source?.category == "Test",
				"Initializing Source source?.category failed!")
		#expect(source?.country == "Test",
				"Initializing Source source?.country failed!")
		#expect(source?.id == "Test",
				"Initializing Source source?.id failed!")
		#expect(source?.language == "Test",
				"Initializing Source source?.language failed!")
		#expect(source?.name == "Test",
				"Initializing Source source?.name failed!")
		#expect(source?.story == "Test",
				"Initializing Source source?.story failed!")
		#expect(source?.url == URL(string: "Test"),
				"Initializing Source source?.url failed!")
	}
}
