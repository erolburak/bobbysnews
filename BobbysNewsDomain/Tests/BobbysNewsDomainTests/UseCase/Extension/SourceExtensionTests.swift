//
//  SourceExtensionTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

struct SourceExtensionTests {

	// MARK: - Actions

	@Test("Check SourceExtension Source initializing!")
	func testSource() {
		// Given
		var entity = EntityMock()
		let sourceDB = entity.sourceDB
		// When
		let source = Source(from: sourceDB)
		// Then
		#expect(source?.category == "Test" &&
				source?.country == "Test" &&
				source?.id == "Test" &&
				source?.language == "Test" &&
				source?.name == "Test" &&
				source?.story == "Test" &&
				source?.url == URL(string: "Test"),
				"SourceExtension Source initializing failed!")
	}
}
