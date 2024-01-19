//
//  FetchSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import Combine

protocol PFetchSourcesUseCase {

	// MARK: - Actions

	func fetch(apiKey: String) -> AnyPublisher<SourcesDTO, Error>
}

class FetchSourcesUseCase: PFetchSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesRepository: PSourcesRepository

	// MARK: - Inits

	init(sourcesRepository: PSourcesRepository) {
		self.sourcesRepository = sourcesRepository
	}

	// MARK: - Actions

	func fetch(apiKey: String) -> AnyPublisher<SourcesDTO, Error> {
		sourcesRepository
			.fetch(apiKey: apiKey)
			.eraseToAnyPublisher()
	}
}
