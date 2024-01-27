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

class DeleteSourcesUseCase: PDeleteSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesRepository: PSourcesRepository

	// MARK: - Inits

	init(sourcesRepository: PSourcesRepository) {
		self.sourcesRepository = sourcesRepository
	}

	// MARK: - Actions

	func delete() throws {
		try sourcesRepository
			.delete()
	}
}
