//
//  SourcesNetworkControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

public final class SourcesNetworkControllerMock: PSourcesNetworkController {
    // MARK: - Methods

    public func fetch(apiKey _: Int) -> SourcesAPI {
        EntityMock.sourcesAPI
    }
}
