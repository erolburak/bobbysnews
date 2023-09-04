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

	func fetch(country: Country) -> AnyPublisher<TopHeadlinesDTO, Error> {
		if country != .none {
			return Just(TopHeadlinesDTO(articles: [ArticleDTO(author: "Test",
															  content: "Test",
															  publishedAt: "Test",
															  source: SourceDTO(id: "Test",
																				name: "Test"),
															  story: "Test",
															  title: "Test",
															  url: URL(string: "Test"),
															  urlToImage: URL(string: "Test"))],
										status: "Test",
										totalResults: 1))
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
		} else {
			return Fail<TopHeadlinesDTO, Error>(error: AppConfiguration.Errors.fetchTopHeadlines).eraseToAnyPublisher()
		}
	}
}
