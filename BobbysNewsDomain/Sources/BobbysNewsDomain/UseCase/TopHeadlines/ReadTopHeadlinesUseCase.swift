//
//  ReadTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 03.09.23.
//

import BobbysNewsData

public protocol PReadTopHeadlinesUseCase {

	// MARK: - Actions

	func read(country: String) throws -> TopHeadlines
}

public final class ReadTopHeadlinesUseCase: PReadTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Inits

	public init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	public func read(country: String) throws -> TopHeadlines {
		TopHeadlines(articles: try topHeadlinesRepository.read(country: country)
			.compactMap {
				Article(from: $0)
			})
	}
}
