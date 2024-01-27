//
//  SourcesRepositoryMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Combine

class SourcesRepositoryMock: PSourcesRepository {

	// MARK: - Private Properties

	private let sourcesPersistenceController: SourcesPersistenceControllerMock
	private let sourcesNetworkController: SourcesNetworkControllerMock

	// MARK: - Inits

	init(sourcesPersistenceController: SourcesPersistenceControllerMock,
		 sourcesNetworkController: SourcesNetworkControllerMock) {
		self.sourcesPersistenceController = sourcesPersistenceController
		self.sourcesNetworkController = sourcesNetworkController
	}

	// MARK: - Actions

	func delete() throws {
		try sourcesPersistenceController
			.delete()
	}

	func fetch(apiKey: Int) async throws {
		try await sourcesNetworkController
			.fetch(apiKey: apiKey)
	}

	func read() -> AnyPublisher<[SourceDB], Error> {
		sourcesPersistenceController
			.read()
			.eraseToAnyPublisher()
	}
}
