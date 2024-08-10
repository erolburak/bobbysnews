//
//  SourcesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

public final class SourcesNetworkControllerMock: PSourcesNetworkController {

	// MARK: - Actions

	public func fetch(apiKey: Int) -> SourcesAPI {
		EntityMock.sourcesAPI
	}
}
