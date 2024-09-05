//
//  FetchTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 01.09.23.
//

import BobbysNewsData

public protocol PFetchTopHeadlinesUseCase: Sendable {
    // MARK: - Methods

    func fetch(apiKey: Int,
               country: String) async throws
}

public final class FetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase {
    // MARK: - Private Properties

    private let topHeadlinesRepository: PTopHeadlinesRepository

    // MARK: - Lifecycles

    public init(topHeadlinesRepository: PTopHeadlinesRepository) {
        if CommandLine.arguments.contains("–uitesting") {
            self.topHeadlinesRepository = TopHeadlinesRepositoryMock()
        } else {
            self.topHeadlinesRepository = topHeadlinesRepository
        }
    }

    // MARK: - Methods

    public func fetch(apiKey: Int,
                      country: String) async throws
    {
        try await topHeadlinesRepository.fetch(apiKey: apiKey,
                                               country: country)
    }
}
