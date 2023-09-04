//
//  TopHeadlinesQueriesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine
import Foundation

protocol PTopHeadlinesQueriesRepository {
	func delete() throws
	func fetchRequest(country: Country)
	func read() -> AnyPublisher<TopHeadlines, Error>
	func save(country: Country,
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

	func fetchRequest(country: Country) {
		topHeadlinesDataController
			.fetchRequest(country: country)
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		topHeadlinesDataController
			.read()
			.eraseToAnyPublisher()
	}

	func save(country: Country,
			  topHeadlinesDto: TopHeadlinesDTO) {
		topHeadlinesDataController
			.save(country: country,
				  topHeadlinesDto: topHeadlinesDto)
	}
}
