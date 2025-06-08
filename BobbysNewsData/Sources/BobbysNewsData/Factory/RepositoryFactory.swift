//
//  RepositoryFactory.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 24.01.24.
//

public class RepositoryFactory {
    // MARK: - Properties

    public let topHeadlinesRepository: PTopHeadlinesRepository

    // MARK: - Lifecycles

    public init() {
        topHeadlinesRepository = TopHeadlinesRepository()
    }
}
