//
//  SourcesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

public class SourcesNetworkControllerMock: PSourcesNetworkController {

	// MARK: - Actions

	public func fetch(apiKey: Int) async throws -> SourcesAPI {
		EntityMock.sourcesAPI
	}
}
