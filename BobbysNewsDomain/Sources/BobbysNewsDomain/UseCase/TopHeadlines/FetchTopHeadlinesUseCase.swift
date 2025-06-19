//
//  FetchTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 01.09.23.
//

import BobbysNewsData

public protocol PFetchTopHeadlinesUseCase: Sendable {
    // MARK: - Methods

    func fetch(
        apiKey: String,
        category: String,
        country: String
    ) async throws
}

public final class FetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase {
    // MARK: - Private Properties

    private let topHeadlinesRepository: PTopHeadlinesRepository

    // MARK: - Lifecycles

    public init(topHeadlinesRepository: PTopHeadlinesRepository) {
        #if DEBUG
            self.topHeadlinesRepository =
                CommandLine.arguments.contains("–Testing")
                ? TopHeadlinesRepositoryMock() : topHeadlinesRepository
        #else
            self.topHeadlinesRepository = topHeadlinesRepository
        #endif
    }

    // MARK: - Methods

    public func fetch(
        apiKey: String,
        category: String,
        country: String
    ) async throws {
        try await topHeadlinesRepository.fetch(
            apiKey: apiKey,
            category: category,
            country: country
        )
    }
}
