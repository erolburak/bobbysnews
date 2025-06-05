//
//  SourcesRepositoryTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Testing

@Suite("SourcesRepository tests")
struct SourcesRepositoryTests {
    // MARK: - Private Properties

    private let sut = SourcesRepositoryMock()

    // MARK: - Methods

    @Test("Check SourcesRepository delete!")
    func delete() {
        #expect(throws: Never.self,
                "SourcesRepository delete failed!")
        {
            sut.delete()
        }
    }

    @Test("Check SourcesRepository fetch!")
    func fetch() {
        #expect(throws: Never.self,
                "SourcesRepository fetch failed!")
        {
            sut.fetch(apiKey: 1)
        }
    }

    @Test("Check SourcesRepository read!")
    func read() {
        // Given
        var sources: [SourceDB]?
        // When
        sources = sut.read()
        // Then
        #expect(sources?.count == 1,
                "SourcesRepository read failed!")
    }
}
