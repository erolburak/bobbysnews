//
//  TopHeadlinesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

public final class TopHeadlinesNetworkControllerMock: PTopHeadlinesNetworkController {

	// MARK: - Actions

	public func fetch(apiKey: Int,
					  country: String) async throws -> TopHeadlinesAPI {
		if country.isEmpty {
			throw NetworkConfiguration.Errors.fetchTopHeadlines
		} else {
			return EntityMock.topHeadlinesAPI
		}
	}
}
