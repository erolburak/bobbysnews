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

public final class DeleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Inits

	public init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	public func delete(country: String?) throws {
		try topHeadlinesRepository
			.delete(country: country)
	}
}
