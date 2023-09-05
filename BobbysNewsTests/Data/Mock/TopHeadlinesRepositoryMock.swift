//
//  TopHeadlinesRepositoryMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine
import Foundation

class TopHeadlinesRepositoryMock: PTopHeadlinesRepository {

	func fetch(country: String) -> AnyPublisher<TopHeadlinesDTO, Error> {
		if country.isEmpty == false {
			return Just(TopHeadlinesDTO(articles: [ArticleDTO(author: "Test",
															  content: "Test",
															  publishedAt: "Test",
															  source: SourceDTO(category: "Test",
																				country: "Test",
																				id: "Test",
																				language: "Test",
																				name: "Test",
																				story: "Test",
																				url: URL(string: "Test")),
															  story: "Test",
															  title: "Test",
															  url: URL(string: "Test"),
															  urlToImage: URL(string: "Test"))],
										status: "Test",
										totalResults: 1))
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
		} else {
			return Fail<TopHeadlinesDTO, Error>(error: AppConfiguration.Errors.fetch)
				.eraseToAnyPublisher()
		}
	}

	func fetchSources() -> AnyPublisher<SourcesDTO, Error> {
		Just(SourcesDTO(sources: [SourceDTO(category: "Test",
											country: "Test",
											id: "Test",
											language: "Test",
											name: "Test",
											story: "Test",
											url: URL(string: "Test"))],
						status: "Test"))
		.setFailureType(to: Error.self)
		.eraseToAnyPublisher()
	}
}
