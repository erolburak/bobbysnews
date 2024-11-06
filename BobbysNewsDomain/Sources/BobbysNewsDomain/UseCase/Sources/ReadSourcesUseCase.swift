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
        #if DEBUG
            self.sourcesRepository = CommandLine.arguments.contains("–testing") ? SourcesRepositoryMock() : sourcesRepository
        #else
            self.sourcesRepository = sourcesRepository
        #endif
    }

    // MARK: - Methods

    public func read() throws -> Sources {
        try Sources(sources: sourcesRepository.read()
            .compactMap {
                Source(from: $0)
            })
    }
}
