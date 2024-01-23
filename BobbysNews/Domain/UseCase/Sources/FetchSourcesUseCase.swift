//
//  FetchSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

protocol PFetchSourcesUseCase {

	// MARK: - Actions

	func fetch(apiKey: String) async throws
}

class FetchSourcesUseCase: PFetchSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesRepository: PSourcesRepository

	// MARK: - Inits

	init(sourcesRepository: PSourcesRepository) {
		self.sourcesRepository = sourcesRepository
	}

	// MARK: - Actions

	func fetch(apiKey: String) async throws {
		let sourcesApi = try await sourcesRepository.fetch(apiKey: apiKey)
		if sourcesApi.sources != nil ||
			sourcesApi.sources?.isEmpty == false {
			SourcesDataController
				.shared
				.save(sourcesApi: sourcesApi)
		} else {
			try SourcesDataController
				.shared
				.delete()
		}
	}
}
