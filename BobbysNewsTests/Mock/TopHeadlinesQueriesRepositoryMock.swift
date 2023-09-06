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

	// MARK: - Life Cycle

	init(topHeadlinesDataController: TopHeadlinesDataControllerMock) {
		self.topHeadlinesDataController = topHeadlinesDataController
	}

	// MARK: - Actions

	func delete() throws {
		try topHeadlinesDataController
			.delete()
	}

	func fetchRequest(country: String) {
		topHeadlinesDataController
			.fetchRequest(country: country)
	}

	func fetchSourcesRequest() {
		topHeadlinesDataController
			.fetchSourcesRequest()
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		topHeadlinesDataController
			.read()
			.eraseToAnyPublisher()
	}

	func readSources() -> AnyPublisher<Sources, Error> {
		topHeadlinesDataController
			.readSources()
			.eraseToAnyPublisher()
	}

	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO) {
		topHeadlinesDataController
			.save(country: country,
				  topHeadlinesDto: topHeadlinesDto)
	}

	func saveSources(sourcesDto: SourcesDTO) {
		topHeadlinesDataController
			.saveSources(sourcesDto: sourcesDto)
	}
}
