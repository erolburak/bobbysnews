//
//  RepositoryFactory.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 24.01.24.
//

public class RepositoryFactory {
    // MARK: - Properties

    /// Sources
    public let sourcesRepository: PSourcesRepository
    /// TopHeadlines
    public let topHeadlinesRepository: PTopHeadlinesRepository

    // MARK: - Lifecycles

    public init() {
        sourcesRepository = SourcesRepository()
        topHeadlinesRepository = TopHeadlinesRepository()
    }
}
