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
																   country: "Test",
																   publishedAt: .now,
																   source: Source(category: "Test 1",
																				  country: "Test 1",
																				  id: "Test 1",
																				  language: "Test 1",
																				  name: "Test 1",
																				  story: "Test 1",
																				  url: URL(string: "Test 1")),
																   story: "Test 1",
																   title: "Test 1",
																   url: URL(string: "Test 1"),
																   urlToImage: URL(string: "Test 1")),
														   Article(author: "Test 2",
																   content: "Test 2",
																   country: "Test",
																   publishedAt: .now,
																   source: Source(category: "Test 2",
																				  country: "Test 2",
																				  id: "Test 2",
																				  language: "Test 2",
																				  name: "Test 2",
																				  story: "Test 2",
																				  url: URL(string: "Test 2")),
																   story: "Test 2",
																   title: "Test 2",
																   url: URL(string: "Test 2"),
																   urlToImage: URL(string: "Test 2"))],
												status: "Test",
												totalResults: 2)
	private let topHeadlinesSourcesMock = Sources(sources: [Source(category: "Test 1",
																   country: "Test 1",
																   id: "Test 1",
																   language: "Test 1",
																   name: "Test 1",
																   story: "Test 1",
																   url: URL(string: "Test 1")),
															Source(category: "Test 2",
																   country: "Test 2",
																   id: "Test 2",
																   language: "Test 2",
																   name: "Test 2",
																   story: "Test 2",
																   url: URL(string: "Test 2"))],
												status: "Test")
	lazy var topHeadlinesQueriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(topHeadlinesMock)
	lazy var topHeadlinesSourcesQueriesSubject: CurrentValueSubject<Sources?, Never> = CurrentValueSubject(topHeadlinesSourcesMock)

	func delete() throws {
		topHeadlinesQueriesSubject.send(nil)
		topHeadlinesSourcesQueriesSubject.send(nil)
	}

	func fetchRequest(country: String) {
		topHeadlinesQueriesSubject.send(TopHeadlines(articles: topHeadlinesMock.articles?.filter { $0.country == country },
													 status: topHeadlinesMock.status,
													 totalResults: topHeadlinesMock.totalResults))
	}

	func fetchSourcesRequest() {
		topHeadlinesSourcesQueriesSubject.send(topHeadlinesSourcesMock)
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		topHeadlinesQueriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func readSources() -> AnyPublisher<Sources, Error> {
		topHeadlinesSourcesQueriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO) {
		var articles: [Article] = []
		topHeadlinesDto.articles?.forEach { articleDto in
			guard topHeadlinesQueriesSubject.value?.articles?.filter({ $0.title == articleDto.title }).isEmpty == true,
				  articleDto.title?.isEmpty == false,
				  let article = articleDto.toDomain(country: country) else { return }
			articles.append(article)
		}
		topHeadlinesQueriesSubject.send(TopHeadlines(articles: articles + (topHeadlinesMock.articles ?? []),
													 status: topHeadlinesDto.status,
													 totalResults: (topHeadlinesDto.totalResults ?? 0) + (topHeadlinesMock.totalResults ?? 0)))
	}

	func saveSources(sourcesDto: SourcesDTO) {
		var sources: [Source] = []
		sourcesDto.sources?.forEach { sourceDto in
			guard topHeadlinesSourcesQueriesSubject.value?.sources?.filter({ $0.name == sourceDto.name }).isEmpty == true,
				  sourceDto.name?.isEmpty == false,
				  let source = sourceDto.toDomain() else { return }
			sources.append(source)
		}
		topHeadlinesSourcesQueriesSubject.send(Sources(sources: sources + (topHeadlinesSourcesMock.sources ?? []),
													   status: sourcesDto.status))
	}
}
