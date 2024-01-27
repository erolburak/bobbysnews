//
//  SourcesRepositoryMock.swift
//	BobbysNewsDomain
//
//  Created by Burak Erol on 25.01.24.
//

import BobbysNewsData
import Combine

class SourcesRepositoryMock: PSourcesRepository {

	// MARK: - Private Properties

	private let sourcesPersistenceController: SourcesPersistenceControllerMock

	// MARK: - Inits

	init(sourcesPersistenceController: SourcesPersistenceControllerMock) {
		self.sourcesPersistenceController = sourcesPersistenceController
	}

	// MARK: - Actions

	func delete() throws {
		try sourcesPersistenceController
			.delete()
	}

	func fetch(apiKey: Int) async throws {
		sourcesPersistenceController
			.fetchRequest()
	}

	func read() -> AnyPublisher<[SourceDB], Error> {
		sourcesPersistenceController
			.read()
			.eraseToAnyPublisher()
	}
}
