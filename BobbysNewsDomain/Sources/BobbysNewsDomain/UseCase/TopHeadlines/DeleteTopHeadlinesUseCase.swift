//
//  DeleteTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import BobbysNewsData

public protocol PDeleteTopHeadlinesUseCase {

	// MARK: - Actions

	func delete(country: String?) throws
}

class DeleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Inits

	init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	func delete(country: String?) throws {
		try topHeadlinesRepository
			.delete(country: country)
	}
}
