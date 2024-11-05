//
//  DeleteSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 07.09.23.
//

import BobbysNewsData
@testable import BobbysNewsDomain
import Testing

@Suite("DeleteSourcesUseCase tests")
struct DeleteSourcesUseCaseTests {
    // MARK: - Private Properties

    private let sut = DeleteSourcesUseCase(sourcesRepository: SourcesRepositoryMock())

    // MARK: - Methods

    @Test("Check DeleteSourcesUseCase delete!")
    func testDelete() {
        #expect(throws: Never.self,
                "DeleteSourcesUseCase delete failed!")
        {
            try sut.delete()
        }
    }
}
