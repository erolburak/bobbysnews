//
//  SourcesPersistenceControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Testing

@Suite("SourcesPersistenceController tests")
struct SourcesPersistenceControllerTests {
    // MARK: - Private Properties

    private let sut = SourcesPersistenceControllerMock()

    // MARK: - Methods

    @Test("Check SourcesPersistenceController delete!")
    func delete() {
        #expect(throws: Never.self,
                "SourcesPersistenceController delete failed!")
        {
            sut.delete()
        }
    }

    @Test("Check SourcesPersistenceController read!")
    func read() {
        // Given
        var sources: [SourceDB]?
        // When
        sources = sut.read()
        // Then
        #expect(sources?.count == 1,
                "SourcesPersistenceController read failed!")
    }

    @Test("Check SourcesPersistenceController save!")
    func save() {
        #expect(throws: Never.self,
                "SourcesPersistenceController save failed!")
        {
            sut.save(sourcesAPI: EntityMock.sourcesAPI)
        }
    }
}
