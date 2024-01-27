//
//  SourcesRepository.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

import Combine

public protocol PSourcesRepository {

	// MARK: - Actions

	func delete() throws
	func fetch(apiKey: Int) async throws
	func read() -> AnyPublisher<[SourceDB], Error>
}

class SourcesRepository: PSourcesRepository {

	// MARK: - Private Properties

	private let sourcesPersistenceController = SourcesPersistenceController.shared
	private let sourcesNetworkController = SourcesNetworkController()

	// MARK: - Actions

	func delete() throws {
		try sourcesPersistenceController
			.delete()
	}

	func fetch(apiKey: Int) async throws {
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

	func read() -> AnyPublisher<[SourceDB], Error> {
		sourcesPersistenceController
			.read()
			.eraseToAnyPublisher()
	}
}
