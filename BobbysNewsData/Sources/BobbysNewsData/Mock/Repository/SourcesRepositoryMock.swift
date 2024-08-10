//
//  SourcesRepositoryMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

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

	public func delete() {
		sourcesPersistenceController.delete()
	}

	public func fetch(apiKey: Int) {
		let sourcesAPI = sourcesNetworkController.fetch(apiKey: apiKey)
		if sourcesAPI.sources != nil ||
			sourcesAPI.sources?.isEmpty == false {
			sourcesPersistenceController.save(sourcesAPI: sourcesAPI)
		} else {
			delete()
		}
	}

	public func read() -> [SourceDB] {
		sourcesPersistenceController.read()
	}
}
