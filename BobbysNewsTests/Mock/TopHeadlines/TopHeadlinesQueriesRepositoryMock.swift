//
//  TopHeadlinesQueriesRepositoryMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine

class TopHeadlinesQueriesRepositoryMock: PTopHeadlinesQueriesRepository {

	// MARK: - Private Properties

	private let topHeadlinesDataController: TopHeadlinesDataControllerMock

	// MARK: - Inits

	init(topHeadlinesDataController: TopHeadlinesDataControllerMock) {
		self.topHeadlinesDataController = topHeadlinesDataController
	}

	// MARK: - Actions

	func delete(country: String?) throws {
		try topHeadlinesDataController
			.delete(country: country)
	}

	func fetchRequest(country: String) {
		topHeadlinesDataController
			.fetchRequest(country: country)
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		topHeadlinesDataController
			.read()
			.eraseToAnyPublisher()
	}
}
