//
//  SourcesRepositoryMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

import Combine

public final class SourcesRepositoryMock: PSourcesRepository {

	// MARK: - Private Properties

	public let sourcesNetworkController: SourcesNetworkControllerMock
	public let sourcesPersistenceController: SourcesPersistenceControllerMock

	// MARK: - Inits

	public init() {
		sourcesNetworkController = SourcesNetworkControllerMock()
		sourcesPersistenceController = SourcesPersistenceControllerMock()
	}

	// MARK: - Actions

	public func delete() throws {
		try sourcesPersistenceController
			.delete()
	}

	public func fetch(apiKey: Int) async throws {
		let sourcesAPI = try await sourcesNetworkController
			.fetch(apiKey: apiKey)
		if sourcesAPI.sources != nil ||
			sourcesAPI.sources?.isEmpty == false {
			sourcesPersistenceController
				.save(sourcesAPI: sourcesAPI)
		} else {
			try delete()
		}
	}

	public func read() -> AnyPublisher<[SourceDB], Error> {
		sourcesPersistenceController
			.read()
			.eraseToAnyPublisher()
	}
}
