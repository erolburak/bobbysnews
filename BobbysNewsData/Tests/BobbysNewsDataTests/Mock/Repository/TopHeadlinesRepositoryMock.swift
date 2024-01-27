//
//  TopHeadlinesRepositoryMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Combine

class TopHeadlinesRepositoryMock: PTopHeadlinesRepository {

	// MARK: - Private Properties

	private let topHeadlinesPersistenceController: TopHeadlinesPersistenceControllerMock
	private let topHeadlinesNetworkController: TopHeadlinesNetworkControllerMock

	// MARK: - Inits

	init(topHeadlinesPersistenceController: TopHeadlinesPersistenceControllerMock,
		 topHeadlinesNetworkController: TopHeadlinesNetworkControllerMock) {
		self.topHeadlinesPersistenceController = topHeadlinesPersistenceController
		self.topHeadlinesNetworkController = topHeadlinesNetworkController
	}

	// MARK: - Actions

	func delete(country: String?) throws {
		try topHeadlinesPersistenceController
			.delete(country: country)
	}

	func fetch(apiKey: Int,
			   country: String) async throws {
		try await topHeadlinesNetworkController
			.fetch(apiKey: apiKey,
				   country: country)
	}

	func read() -> AnyPublisher<[ArticleDB], Error> {
		topHeadlinesPersistenceController
			.read()
			.eraseToAnyPublisher()
	}
}
