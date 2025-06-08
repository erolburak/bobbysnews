//
//  ReadTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 03.09.23.
//

import BobbysNewsData

public protocol PReadTopHeadlinesUseCase {
    // MARK: - Methods

    func read(category: String,
              country: String) throws -> TopHeadlines
}

public final class ReadTopHeadlinesUseCase: PReadTopHeadlinesUseCase {
    // MARK: - Private Properties

    private let topHeadlinesRepository: PTopHeadlinesRepository

    // MARK: - Lifecycles

    public init(topHeadlinesRepository: PTopHeadlinesRepository) {
        #if DEBUG
            self.topHeadlinesRepository = CommandLine.arguments.contains("–testing") ? TopHeadlinesRepositoryMock() : topHeadlinesRepository
        #else
            self.topHeadlinesRepository = topHeadlinesRepository
        #endif
    }

    // MARK: - Methods

    public func read(category: String,
                     country: String) throws -> TopHeadlines
    {
        try TopHeadlines(articles: topHeadlinesRepository.read(category: category,
                                                               country: country)
                .compactMap {
                    Article(from: $0)
                })
    }
}
