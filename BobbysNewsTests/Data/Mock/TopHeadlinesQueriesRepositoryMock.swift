//
//  TopHeadlinesQueriesRepositoryMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine

class TopHeadlinesQueriesRepositoryMock: PTopHeadlinesQueriesRepository {

	private let topHeadlinesDataController: TopHeadlinesDataControllerMock

	init(topHeadlinesDataController: TopHeadlinesDataControllerMock) {
		self.topHeadlinesDataController = topHeadlinesDataController
	}

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

	func save(country: Country, topHeadlinesDto: TopHeadlinesDTO) {
		topHeadlinesDataController
			.save(country: country,
				  topHeadlinesDto: topHeadlinesDto)
	}
}
