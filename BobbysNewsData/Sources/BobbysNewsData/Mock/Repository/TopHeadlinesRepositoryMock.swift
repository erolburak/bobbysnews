//
//  TopHeadlinesRepositoryMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

public final class TopHeadlinesRepositoryMock: PTopHeadlinesRepository {
    // MARK: - Private Properties

    public let topHeadlinesNetworkController: TopHeadlinesNetworkControllerMock
    public let topHeadlinesPersistenceController: TopHeadlinesPersistenceControllerMock

    // MARK: - Lifecycles

    public init() {
        topHeadlinesNetworkController = TopHeadlinesNetworkControllerMock()
        topHeadlinesPersistenceController = TopHeadlinesPersistenceControllerMock()
    }

    // MARK: - Methods

    public func delete() {
        topHeadlinesPersistenceController.delete()
    }

    public func fetch(
        apiKey: String,
        category: String,
        country: String
    ) throws {
        let topHeadlinesAPI = try topHeadlinesNetworkController.fetch(
            apiKey: apiKey,
            category: category,
            country: country
        )
        if topHeadlinesAPI.articles?.isEmpty == false {
            topHeadlinesPersistenceController.save(
                category: category,
                country: country,
                topHeadlinesAPI: topHeadlinesAPI
            )
        } else {
            delete()
        }
    }

    public func read(
        category: String,
        country: String
    ) -> [ArticleDB] {
        topHeadlinesPersistenceController.read(
            category: category,
            country: country
        )
    }
}
