//
//  TopHeadlinesRepositoryMock.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 25.01.24.
//

import BobbysNewsData
import Combine

class TopHeadlinesRepositoryMock: PTopHeadlinesRepository {

	// MARK: - Private Properties

	private let topHeadlinesPersistenceController: TopHeadlinesPersistenceControllerMock

	// MARK: - Inits

	init(topHeadlinesPersistenceController: TopHeadlinesPersistenceControllerMock) {
		self.topHeadlinesPersistenceController = topHeadlinesPersistenceController
	}

	// MARK: - Actions

	func delete(country: String?) throws {
		try topHeadlinesPersistenceController
			.delete(country: country)
	}

	func fetch(apiKey: Int,
			   country: String) async throws {
		topHeadlinesPersistenceController
			.fetchRequest(country: country)
	}

	func read() -> AnyPublisher<[ArticleDB], Error> {
		topHeadlinesPersistenceController
			.read()
			.eraseToAnyPublisher()
	}
}
