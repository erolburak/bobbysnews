//
//  TopHeadlinesRepositoryMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews

class TopHeadlinesRepositoryMock: PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) async throws -> TopHeadlinesApi {
		if !country.isEmpty {
			return ApiMock.topHeadlinesApi1
		} else {
			throw AppConfiguration.Errors.fetchTopHeadlines
		}
	}
}
