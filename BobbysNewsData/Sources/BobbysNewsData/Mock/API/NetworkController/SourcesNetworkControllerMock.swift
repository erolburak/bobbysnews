//
//  SourcesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

public final class SourcesNetworkControllerMock: PSourcesNetworkController {

	// MARK: - Private Properties

	private let entity = EntityMock()

	// MARK: - Actions

	public func fetch(apiKey: Int) async throws -> SourcesAPI {
		entity.sourcesAPI
	}
}
