//
//  FetchSourcesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

import BobbysNewsData

public protocol PFetchSourcesUseCase: Sendable {
    // MARK: - Methods

    func fetch(apiKey: Int) async throws
}

public final class FetchSourcesUseCase: PFetchSourcesUseCase {
    // MARK: - Private Properties

    private let sourcesRepository: PSourcesRepository

    // MARK: - Lifecycles

    public init(sourcesRepository: PSourcesRepository) {
        if CommandLine.arguments.contains("–uitesting") {
            self.sourcesRepository = SourcesRepositoryMock()
        } else {
            self.sourcesRepository = sourcesRepository
        }
    }

    // MARK: - Methods

    public func fetch(apiKey: Int) async throws {
        try await sourcesRepository.fetch(apiKey: apiKey)
    }
}
