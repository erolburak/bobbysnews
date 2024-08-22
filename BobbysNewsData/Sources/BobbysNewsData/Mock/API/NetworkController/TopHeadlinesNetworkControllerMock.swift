//
//  TopHeadlinesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

public final class TopHeadlinesNetworkControllerMock: PTopHeadlinesNetworkController {
    // MARK: - Methods

    public func fetch(apiKey: Int,
                      country: String) throws -> TopHeadlinesAPI
    {
        if country.isEmpty {
            throw NetworkConfiguration.Errors.fetchTopHeadlines
        } else {
            return EntityMock.topHeadlinesAPI
        }
    }
}
