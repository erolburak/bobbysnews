//
//  ReadSourcesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

import BobbysNewsData

public protocol PReadSourcesUseCase {
    // MARK: - Methods

    func read() throws -> Sources
}

public final class ReadSourcesUseCase: PReadSourcesUseCase {
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

    public func read() throws -> Sources {
        try Sources(sources: sourcesRepository.read()
            .compactMap {
                Source(from: $0)
            })
    }
}
