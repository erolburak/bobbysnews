//
//  ReadSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
import Testing

struct ReadSourcesUseCaseTests {

	// MARK: - Private Properties

	private let sut = ReadSourcesUseCase(sourcesRepository: SourcesRepositoryMock())

	// MARK: - Actions

	@Test("Check ReadSourcesUseCase read!")
	func testRead() throws {
		// Given
		var sources: Sources?
		// When
		sources = try sut.read()
		// Then
		#expect(sources?.sources?.count == 1,
				"ReadSourcesUseCase read failed!")
	}
}
