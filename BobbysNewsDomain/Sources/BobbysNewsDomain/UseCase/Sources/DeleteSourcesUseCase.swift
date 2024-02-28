//
//  DeleteSourcesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 07.09.23.
//

import BobbysNewsData

public protocol PDeleteSourcesUseCase {

	// MARK: - Actions

	func delete() throws
}

public final class DeleteSourcesUseCase: PDeleteSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesRepository: PSourcesRepository

	// MARK: - Inits

	public init(sourcesRepository: PSourcesRepository) {
		self.sourcesRepository = sourcesRepository
	}

	// MARK: - Actions

	public func delete() throws {
		try sourcesRepository
			.delete()
	}
}
