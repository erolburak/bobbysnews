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

	// MARK: - Inits

	public init() {
		topHeadlinesNetworkController = TopHeadlinesNetworkControllerMock()
		topHeadlinesPersistenceController = TopHeadlinesPersistenceControllerMock()
	}

	// MARK: - Actions

	public func delete() {
		topHeadlinesPersistenceController.delete()
	}

	public func fetch(apiKey: Int,
					  country: String) throws {
		let topHeadlinesAPI = try topHeadlinesNetworkController.fetch(apiKey: apiKey,
																	  country: country)
		if topHeadlinesAPI.articles != nil ||
			topHeadlinesAPI.articles?.isEmpty == false {
			topHeadlinesPersistenceController.save(country: country,
												   topHeadlinesAPI: topHeadlinesAPI)
		} else {
			delete()
		}
	}

	public func read(country: String) -> [ArticleDB] {
		topHeadlinesPersistenceController.read(country: country)
	}
}
