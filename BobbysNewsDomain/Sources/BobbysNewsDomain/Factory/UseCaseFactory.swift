//
//  UseCaseFactory.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

import BobbysNewsData

public final class UseCaseFactory {

	// MARK: - Properties

	/// Sources
	public let deleteSourcesUseCase: PDeleteSourcesUseCase
	public let fetchSourcesUseCase: PFetchSourcesUseCase
	public let readSourcesUseCase: PReadSourcesUseCase
	/// TopHeadlines
	public let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
	public let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
	public let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase

	// MARK: - Inits

	public init() {
		let repositoryFactory = RepositoryFactory()
		deleteSourcesUseCase = DeleteSourcesUseCase(sourcesRepository: repositoryFactory.sourcesRepository)
		fetchSourcesUseCase = FetchSourcesUseCase(sourcesRepository: repositoryFactory.sourcesRepository)
		readSourcesUseCase = ReadSourcesUseCase(sourcesRepository: repositoryFactory.sourcesRepository)
		deleteTopHeadlinesUseCase = DeleteTopHeadlinesUseCase(topHeadlinesRepository: repositoryFactory.topHeadlinesRepository)
		fetchTopHeadlinesUseCase = FetchTopHeadlinesUseCase(topHeadlinesRepository: repositoryFactory.topHeadlinesRepository)
		readTopHeadlinesUseCase = ReadTopHeadlinesUseCase(topHeadlinesRepository: repositoryFactory.topHeadlinesRepository)
	}
}
