//
//  TopHeadlinesDataControllerMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine

class TopHeadlinesDataControllerMock: PTopHeadlinesDataController {

	// MARK: - Properties

	var topHeadlinesQueriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(EntityMock.topHeadlines1)
	var topHeadlinesSourcesQueriesSubject: CurrentValueSubject<Sources?, Never> = CurrentValueSubject(EntityMock.sources1)

	// MARK: - Actions

	func delete() throws {
		topHeadlinesQueriesSubject.send(nil)
		topHeadlinesSourcesQueriesSubject.send(nil)
	}

	func fetchRequest(country: String) {
		topHeadlinesQueriesSubject.send(TopHeadlines(articles: EntityMock.topHeadlines1.articles?.filter { $0.country == country },
													 status: EntityMock.topHeadlines1.status,
													 totalResults: EntityMock.topHeadlines1.totalResults))
	}

	func fetchSourcesRequest() {
		topHeadlinesSourcesQueriesSubject.send(EntityMock.sources1)
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
		topHeadlinesQueriesSubject.send(TopHeadlines(articles: articles + (EntityMock.topHeadlines1.articles ?? []),
													 status: topHeadlinesDto.status,
													 totalResults: (topHeadlinesDto.totalResults ?? 0) + (EntityMock.topHeadlines1.totalResults ?? 0)))
	}

	func saveSources(sourcesDto: SourcesDTO) {
		var sources: [Source] = []
		sourcesDto.sources?.forEach { sourceDto in
			guard topHeadlinesSourcesQueriesSubject.value?.sources?.filter({ $0.id == sourceDto.id }).isEmpty == true,
				  sourceDto.name?.isEmpty == false,
				  let source = sourceDto.toDomain() else { return }
			sources.append(source)
		}
		topHeadlinesSourcesQueriesSubject.send(Sources(sources: sources + (EntityMock.sources1.sources ?? []),
													   status: sourcesDto.status))
	}
}
