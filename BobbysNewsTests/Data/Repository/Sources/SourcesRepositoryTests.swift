//
//  SourcesRepositoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews
import XCTest

class SourcesRepositoryTests: XCTestCase {
    // MARK: - Private Properties

    private var sut: SourcesRepositoryMock!

    // MARK: - Actions

    override func setUpWithError() throws {
        sut = SourcesRepositoryMock()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetch() async throws {
        // Given
        var sourcesApi: SourcesApi?
        // When
        sourcesApi = try await sut.fetch(apiKey: "Test")
        // Then
        XCTAssertNotNil(sourcesApi)
    }
}
