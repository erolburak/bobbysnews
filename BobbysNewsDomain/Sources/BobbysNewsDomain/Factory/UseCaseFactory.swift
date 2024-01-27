//
//  UseCaseFactory.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

import BobbysNewsData

public class UseCaseFactory {

	// MARK: - Private Properties

	private let repositoryFactory: RepositoryFactory

	// MARK: - Properties

	public lazy var deleteSourcesUseCase: PDeleteSourcesUseCase = {
		DeleteSourcesUseCase(sourcesRepository: repositoryFactory.sourcesRepository)
	}()
	public lazy var fetchSourcesUseCase: PFetchSourcesUseCase = {
		FetchSourcesUseCase(sourcesRepository: repositoryFactory.sourcesRepository)
	}()
	public lazy var readSourcesUseCase: PReadSourcesUseCase = {
		ReadSourcesUseCase(sourcesRepository: repositoryFactory.sourcesRepository)
	}()
	public lazy var deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase = {
		DeleteTopHeadlinesUseCase(topHeadlinesRepository: repositoryFactory.topHeadlinesRepository)
	}()
	public lazy var fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase = {
		FetchTopHeadlinesUseCase(topHeadlinesRepository: repositoryFactory.topHeadlinesRepository)
	}()
	public lazy var readTopHeadlinesUseCase: PReadTopHeadlinesUseCase = {
		ReadTopHeadlinesUseCase(topHeadlinesRepository: repositoryFactory.topHeadlinesRepository)
	}()

	// MARK: - Inits

	public init() {
		repositoryFactory = RepositoryFactory()
	}
}
