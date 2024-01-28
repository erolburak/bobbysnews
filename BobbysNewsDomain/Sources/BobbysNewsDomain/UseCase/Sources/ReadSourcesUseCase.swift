//
//  ReadSourcesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

import BobbysNewsData
import Combine

public protocol PReadSourcesUseCase {

	// MARK: - Actions

	func read() -> AnyPublisher<Sources, Error>
}

public class ReadSourcesUseCase: PReadSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesRepository: PSourcesRepository

	// MARK: - Inits

	public init(sourcesRepository: PSourcesRepository) {
		self.sourcesRepository = sourcesRepository
	}

	// MARK: - Actions

	public func read() -> AnyPublisher<Sources, Error> {
		sourcesRepository
			.read()
			.compactMap {
				Sources(sources: $0.compactMap { sourceDB in
					Source(from: sourceDB)
				})
			}
			.eraseToAnyPublisher()
	}
}
