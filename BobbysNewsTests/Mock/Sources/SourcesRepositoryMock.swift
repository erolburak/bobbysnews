//
//  SourcesRepositoryMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews

class SourcesRepositoryMock: PSourcesRepository {

	// MARK: - Actions

	func fetch(apiKey: String) async throws -> SourcesApi {
		ApiMock.sourcesApi1
	}
}
