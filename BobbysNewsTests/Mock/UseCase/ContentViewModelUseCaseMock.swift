//
//  ContentViewModelUseCaseMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 26.01.24.
//

import BobbysNewsDomain
import Combine

struct ContentViewModelUseCaseMock: PDeleteSourcesUseCase,
									PFetchSourcesUseCase,
									PReadSourcesUseCase,
									PDeleteTopHeadlinesUseCase,
									PFetchTopHeadlinesUseCase,
									PReadTopHeadlinesUseCase {

	// MARK: - Actions
	
	func delete() throws {}

	func fetch(apiKey: Int) async throws {}

	func read() -> AnyPublisher<Sources, any Error> {
		Just(EntityMock.sources)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func delete(country: String?) throws {}

	func fetch(apiKey: Int,
			   country: String) async throws {}

	func read() -> AnyPublisher<TopHeadlines, any Error> {
		Just(EntityMock.topHeadlines)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
}
