//
//  UseCaseFactory.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

import BobbysNewsData

public final class UseCaseFactory {
    // MARK: - Properties

    public let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
    public let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
    public let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase

    // MARK: - Lifecycles

    public init() {
        let repositoryFactory = RepositoryFactory()
        deleteTopHeadlinesUseCase = DeleteTopHeadlinesUseCase(
            topHeadlinesRepository: repositoryFactory.topHeadlinesRepository
        )
        fetchTopHeadlinesUseCase = FetchTopHeadlinesUseCase(
            topHeadlinesRepository: repositoryFactory.topHeadlinesRepository
        )
        readTopHeadlinesUseCase = ReadTopHeadlinesUseCase(
            topHeadlinesRepository: repositoryFactory.topHeadlinesRepository
        )
    }
}
