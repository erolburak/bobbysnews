//
//  TopHeadlinesRepository.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 03.09.23.
//

import Combine

public protocol PTopHeadlinesRepository {

	// MARK: - Actions

	func delete() throws
	func fetch(apiKey: Int,
			   country: String) async throws
	func read() -> AnyPublisher<[ArticleDB], Error>
}

final class TopHeadlinesRepository: PTopHeadlinesRepository {

	// MARK: - Private Properties

	private let topHeadlinesPersistenceController = TopHeadlinesPersistenceController.shared
	private let topHeadlinesNetworkController = TopHeadlinesNetworkController()

	// MARK: - Actions

	func delete() throws {
		try topHeadlinesPersistenceController
			.delete()
	}

	func fetch(apiKey: Int,
			   country: String) async throws {
		let topHeadlinesAPI = try await topHeadlinesNetworkController
			.fetch(apiKey: apiKey,
				   country: country)
		if topHeadlinesAPI.articles != nil ||
			topHeadlinesAPI.articles?.isEmpty == false {
			topHeadlinesPersistenceController
				.save(country: country,
					  topHeadlinesAPI: topHeadlinesAPI)
		} else {
			try delete()
		}
	}

	func read() -> AnyPublisher<[ArticleDB], Error> {
		topHeadlinesPersistenceController
			.read()
			.eraseToAnyPublisher()
	}
}
