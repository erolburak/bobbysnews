//
//  RepositoryFactory.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 24.01.24.
//

public class RepositoryFactory {

	// MARK: - Properties

	public lazy var sourcesRepository: PSourcesRepository = {
		SourcesRepository()
	}()

	public lazy var topHeadlinesRepository: PTopHeadlinesRepository = {
		TopHeadlinesRepository()
	}()

	// MARK: - Inits

	public init() {}
}
