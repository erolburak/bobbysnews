//
//  FetchSourcesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

import BobbysNewsData

public protocol PFetchSourcesUseCase {

	// MARK: - Actions

	func fetch(apiKey: Int) async throws
}

class FetchSourcesUseCase: PFetchSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesRepository: PSourcesRepository

	// MARK: - Inits

	init(sourcesRepository: PSourcesRepository) {
		self.sourcesRepository = sourcesRepository
	}

	// MARK: - Actions

	func fetch(apiKey: Int) async throws {
		try await sourcesRepository
			.fetch(apiKey: apiKey)
	}
}
