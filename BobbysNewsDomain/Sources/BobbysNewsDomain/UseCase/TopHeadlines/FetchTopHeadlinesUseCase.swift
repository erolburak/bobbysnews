//
//  FetchTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 01.09.23.
//

import BobbysNewsData

public protocol PFetchTopHeadlinesUseCase {

	// MARK: - Actions

	func fetch(apiKey: Int,
			   country: String) async throws
}

public class FetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Inits

	public init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	public func fetch(apiKey: Int,
					  country: String) async throws {
		try await topHeadlinesRepository
			.fetch(apiKey: apiKey,
				   country: country)
	}
}
