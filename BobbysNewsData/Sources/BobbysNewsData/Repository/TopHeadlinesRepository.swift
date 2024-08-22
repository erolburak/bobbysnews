//
//  TopHeadlinesRepository.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 03.09.23.
//

public protocol PTopHeadlinesRepository: Sendable {
    // MARK: - Methods

    func delete() throws
    func fetch(apiKey: Int,
               country: String) async throws
    func read(country: String) throws -> [ArticleDB]
}

final class TopHeadlinesRepository: PTopHeadlinesRepository {
    // MARK: - Private Properties

    private let topHeadlinesPersistenceController = TopHeadlinesPersistenceController()
    private let topHeadlinesNetworkController = TopHeadlinesNetworkController()

    // MARK: - Methods

    func delete() throws {
        try topHeadlinesPersistenceController.delete()
    }

    func fetch(apiKey: Int,
               country: String) async throws
    {
        let topHeadlinesAPI = try await topHeadlinesNetworkController.fetch(apiKey: apiKey,
                                                                            country: country)
        if topHeadlinesAPI.articles != nil ||
            topHeadlinesAPI.articles?.isEmpty == false
        {
            try topHeadlinesPersistenceController.save(country: country,
                                                       topHeadlinesAPI: topHeadlinesAPI)
        } else {
            try delete()
        }
    }

    func read(country: String) throws -> [ArticleDB] {
        try topHeadlinesPersistenceController.read(country: country)
    }
}
