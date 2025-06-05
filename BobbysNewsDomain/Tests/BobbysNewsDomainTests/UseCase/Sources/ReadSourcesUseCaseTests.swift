//
//  ReadSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

import BobbysNewsData
@testable import BobbysNewsDomain
import Testing

@Suite("ReadSourcesUseCase tests")
struct ReadSourcesUseCaseTests {
    // MARK: - Private Properties

    private let sut = ReadSourcesUseCase(sourcesRepository: SourcesRepositoryMock())

    // MARK: - Methods

    @Test("Check ReadSourcesUseCase read!")
    func read() throws {
        // Given
        var sources: Sources?
        // When
        sources = try sut.read()
        // Then
        #expect(sources?.sources?.count == 1,
                "ReadSourcesUseCase read failed!")
    }
}
