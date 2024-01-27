//
//  TopHeadlinesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData

class TopHeadlinesNetworkControllerMock: PTopHeadlinesNetworkController {

	// MARK: - Actions

	func fetch(apiKey: Int,
			   country: String) async throws -> TopHeadlinesAPI {
		if country.isEmpty {
			throw NetworkConfiguration.Errors.fetchTopHeadlines
		} else {
			return EntityMock.topHeadlinesAPI
		}
	}
}
