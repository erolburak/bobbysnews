//
//  TopHeadlinesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

public class TopHeadlinesNetworkControllerMock: PTopHeadlinesNetworkController {

	// MARK: - Inits

	public init() {}

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
