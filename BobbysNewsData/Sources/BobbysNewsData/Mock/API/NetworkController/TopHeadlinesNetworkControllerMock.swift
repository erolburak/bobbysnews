//
//  TopHeadlinesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

public final class TopHeadlinesNetworkControllerMock: PTopHeadlinesNetworkController {
    // MARK: - Methods

    public func fetch(
        apiKey _: String,
        category _: String,
        country _: String
    ) throws -> TopHeadlinesAPI {
        EntityMock.topHeadlinesAPI
    }
}
