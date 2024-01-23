//
//  TopHeadlinesQueriesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine

protocol PTopHeadlinesQueriesRepository {

	// MARK: - Actions

	func delete(country: String?) throws
	func fetchRequest(country: String)
	func read() -> AnyPublisher<TopHeadlines, Error>
}

class TopHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository {

	// MARK: - Private Properties

	private let topHeadlinesDataController = TopHeadlinesDataController.shared

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
