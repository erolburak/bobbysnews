//
//  TopHeadlinesRepositoryMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

import Combine

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

	public func delete() throws {
		try topHeadlinesPersistenceController
			.delete()
	}

	public func fetch(apiKey: Int,
					  country: String) async throws {
		let topHeadlinesAPI = try await topHeadlinesNetworkController
			.fetch(apiKey: apiKey,
				   country: country)
		if topHeadlinesAPI.articles != nil ||
			topHeadlinesAPI.articles?.isEmpty == false {
			topHeadlinesPersistenceController
				.save(country: country,
					  topHeadlinesAPI: topHeadlinesAPI)
		} else {
			try delete()
		}
	}

	public func read() -> AnyPublisher<[ArticleDB], Error> {
		topHeadlinesPersistenceController
			.read()
			.eraseToAnyPublisher()
	}
}
