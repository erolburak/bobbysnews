//
//  SourcesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData

class SourcesNetworkControllerMock: PSourcesNetworkController {

	// MARK: - Actions

	func fetch(apiKey: Int) async throws -> SourcesAPI {
		EntityMock.sourcesAPI
	}
}
