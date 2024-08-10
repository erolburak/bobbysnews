//
//  SourcesRepositoryTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Testing

struct SourcesRepositoryTests {

	// MARK: - Private Properties

	private let sut = SourcesRepositoryMock()

	// MARK: - Actions

	@Test("Check SourcesRepository delete!")
	func testDelete() {
		#expect(throws: Never.self,
				"SourcesRepository delete failed!") {
			sut.delete()
		}
	}

	@Test("Check SourcesRepository fetch!")
	func testFetch() {
		#expect(throws: Never.self,
				"SourcesRepository fetch failed!") {
			sut.fetch(apiKey: 1)
		}
	}

	@Test("Check SourcesRepository read!")
	func testRead() {
		// Given
		var sources: [SourceDB]?
		// When
		sources = sut.read()
		// Then
		#expect(sources?.count == 1,
				"SourcesRepository read failed!")
	}
}
