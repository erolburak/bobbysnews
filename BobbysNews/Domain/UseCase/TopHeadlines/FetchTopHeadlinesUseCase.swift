//
//  FetchTopHeadlinesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 01.09.23.
//

protocol PFetchTopHeadlinesUseCase {

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) async throws -> TopHeadlinesDTO
}

class FetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Inits

	init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) async throws -> TopHeadlinesDTO {
		try await topHeadlinesRepository
			.fetch(apiKey: apiKey,
				   country: country)
	}
}
