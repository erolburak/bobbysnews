//
//  DeleteTopHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import BobbysNewsData
import Testing

@testable import BobbysNewsDomain

@Suite("DeleteTopHeadlinesUseCase tests")
struct DeleteTopHeadlinesUseCaseTests {
    // MARK: - Private Properties

    private let sut = DeleteTopHeadlinesUseCase(
        topHeadlinesRepository: TopHeadlinesRepositoryMock())

    // MARK: - Methods

    @Test("Check DeleteTopHeadlinesUseCase delete!")
    func delete() {
        #expect(
            throws: Never.self,
            "DeleteTopHeadlinesUseCase delete failed!"
        ) {
            try sut.delete()
        }
    }
}
