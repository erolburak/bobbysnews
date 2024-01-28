//
//  ReadTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 03.09.23.
//

import BobbysNewsData
import Combine

public protocol PReadTopHeadlinesUseCase {

	// MARK: - Actions

	func read() -> AnyPublisher<TopHeadlines, Error>
}

public class ReadTopHeadlinesUseCase: PReadTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Inits

	public init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	public func read() -> AnyPublisher<TopHeadlines, Error> {
		topHeadlinesRepository
			.read()
			.compactMap {
				TopHeadlines(articles: $0.compactMap { articleDB in
					Article(from: articleDB)
				})
			}
			.eraseToAnyPublisher()
	}
}
