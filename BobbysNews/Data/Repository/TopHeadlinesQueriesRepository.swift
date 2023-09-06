//
//  TopHeadlinesQueriesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine
import Foundation

protocol PTopHeadlinesQueriesRepository {

	// MARK: - Actions

	func delete() throws
	func fetchRequest(country: String)
	func fetchSourcesRequest()
	func read() -> AnyPublisher<TopHeadlines, Error>
	func readSources() -> AnyPublisher<Sources, Error>
	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO)
	func saveSources(sourcesDto: SourcesDTO)
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
