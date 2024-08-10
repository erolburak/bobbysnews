//
//  ReadSourcesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

import BobbysNewsData

public protocol PReadSourcesUseCase {

	// MARK: - Actions

	func read() throws -> Sources
}

public final class ReadSourcesUseCase: PReadSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesRepository: PSourcesRepository

	// MARK: - Inits

	public init(sourcesRepository: PSourcesRepository) {
		self.sourcesRepository = sourcesRepository
	}

	// MARK: - Actions

	public func read() throws -> Sources {
		Sources(sources: try sourcesRepository.read()
			.compactMap {
				Source(from: $0)
			})
	}
}
