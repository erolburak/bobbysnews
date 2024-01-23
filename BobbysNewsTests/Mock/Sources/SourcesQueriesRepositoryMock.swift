//
//  SourcesQueriesRepositoryMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews
import Combine

class SourcesQueriesRepositoryMock: PSourcesQueriesRepository {

	// MARK: - Private Properties

	private let sourcesDataController: SourcesDataControllerMock

	// MARK: - Inits

	init(sourcesDataController: SourcesDataControllerMock) {
		self.sourcesDataController = sourcesDataController
	}

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
}
