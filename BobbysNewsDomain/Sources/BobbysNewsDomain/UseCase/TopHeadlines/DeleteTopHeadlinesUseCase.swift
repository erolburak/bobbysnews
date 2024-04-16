//
//  DeleteTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import BobbysNewsData

public protocol PDeleteTopHeadlinesUseCase {

	// MARK: - Actions

	func delete() throws
}

public final class DeleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Inits

	public init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	public func delete() throws {
		try topHeadlinesRepository
			.delete()
	}
}
