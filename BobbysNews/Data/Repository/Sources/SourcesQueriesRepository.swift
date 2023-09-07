//
//  SourcesQueriesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 07.09.23.
//

import Combine

protocol PSourcesQueriesRepository {

	// MARK: - Actions

	func delete() throws
	func fetchRequest()
	func read() -> AnyPublisher<Sources, Error>
	func save(sourcesDto: SourcesDTO)
}

class SourcesQueriesRepository: PSourcesQueriesRepository {

	// MARK: - Private Properties

	private let sourcesDataController = SourcesDataController.shared

	// MARK: - Actions

	func delete() throws {
		try sourcesDataController
			.delete()
	}

	func fetchRequest() {
		sourcesDataController
			.fetchRequest()
	}

	func read() -> AnyPublisher<Sources, Error> {
		sourcesDataController
			.read()
			.eraseToAnyPublisher()
	}

	func save(sourcesDto: SourcesDTO) {
		sourcesDataController
			.save(sourcesDto: sourcesDto)
	}
}
