//
//  TopHeadlinesQueriesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine

protocol PTopHeadlinesQueriesRepository {

	// MARK: - Actions

	func delete() throws
	func fetchRequest(country: String)
	func read() -> AnyPublisher<TopHeadlines, Error>
	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO)
}

class TopHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository {

	// MARK: - Private Properties

	private let topHeadlinesDataController = TopHeadlinesDataController.shared

	// MARK: - Actions

	func delete() throws {
		try topHeadlinesDataController
			.delete()
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

	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO) {
		topHeadlinesDataController
			.save(country: country,
				  topHeadlinesDto: topHeadlinesDto)
	}
}
