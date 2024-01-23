//
//  FetchTopHeadlinesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 01.09.23.
//

protocol PFetchTopHeadlinesUseCase {

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) async throws
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
			   country: String) async throws {
		let topHeadlinesApi = try await topHeadlinesRepository.fetch(apiKey: apiKey,
																	 country: country)
		if topHeadlinesApi.articles != nil ||
			topHeadlinesApi.articles?.isEmpty == false {
			TopHeadlinesDataController
				.shared
				.save(country: country,
					  topHeadlinesApi: topHeadlinesApi)
		} else {
			try TopHeadlinesDataController
				.shared
				.delete(country: country)
		}
	}
}
