//
//  TopHeadlinesDataControllerMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine
import Foundation

class TopHeadlinesDataControllerMock: PTopHeadlinesDataController {

	private let topHeadlinesMock = TopHeadlines(articles: [Article(author: "Test 1",
																   content: "Test 1",
																   country: .germany,
																   publishedAt: .now,
																   source: Source(id: "Test 1",
																				  name: "Test 1"),
																   story: "Test 1",
																   title: "Test 1",
																   url: URL(string: "Test 1"),
																   urlToImage: URL(string: "Test 1")),
														   Article(author: "Test 2",
																   content: "Test 2",
																   country: .germany,
																   publishedAt: .now,
																   source: Source(id: "Test 2",
																				  name: "Test 2"),
																   story: "Test 2",
																   title: "Test 2",
																   url: URL(string: "Test 2"),
																   urlToImage: URL(string: "Test 2"))],
												status: "Test",
												totalResults: 2)
	lazy var topHeadlinesQueriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(topHeadlinesMock)

	func delete() throws {
		topHeadlinesQueriesSubject.send(nil)
	}

	func fetchRequest(country: Country) {
		topHeadlinesQueriesSubject.send(TopHeadlines(articles: topHeadlinesMock.articles?.filter { $0.country == country },
													 status: topHeadlinesMock.status,
													 totalResults: topHeadlinesMock.totalResults))
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		topHeadlinesQueriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: Country,
			  topHeadlinesDto: TopHeadlinesDTO) {
		var articles: [Article] = []
		topHeadlinesDto.articles?.forEach { articleDto in
			guard topHeadlinesQueriesSubject.value?.articles?.filter({ $0.title == articleDto.title }).isEmpty == true,
			let article = articleDto.toDomain(country: country) else { return }
			articles.append(article)
		}
		let topHeadlines = TopHeadlines(articles: articles + (topHeadlinesMock.articles ?? []),
										status: topHeadlinesDto.status,
										totalResults: (topHeadlinesDto.totalResults ?? 0) + (topHeadlinesMock.totalResults ?? 0))
		topHeadlinesQueriesSubject.send(topHeadlines)
	}
}
