//
//  TopHeadlinesDataController.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine
import CoreData

protocol PTopHeadlinesDataController {

	// MARK: - Properties

	var topHeadlinesQueriesSubject: CurrentValueSubject<TopHeadlines?, Never> { get }

	// MARK: - Actions

	func delete() throws
	func fetchRequest(country: String)
	func read() -> AnyPublisher<TopHeadlines, Error>
	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO)
}

class TopHeadlinesDataController: PTopHeadlinesDataController {

	// MARK: - Properties

	static let shared = TopHeadlinesDataController()

	// MARK: - Private Properties

	internal let topHeadlinesQueriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(nil)
	internal let topHeadlinesSourcesQueriesSubject: CurrentValueSubject<Sources?, Never> = CurrentValueSubject(nil)
	private let backgroundContext = DataController.shared.backgroundContext

	// MARK: - Actions

	func delete() throws {
		/// Delete all article entities
		try backgroundContext.performAndWait {
			let articlesFetchRequest = ArticleEntity.fetchRequest()
			let articles = try backgroundContext.fetch(articlesFetchRequest)
			articles.forEach { article in
				backgroundContext.delete(article)
			}
			try backgroundContext.save()
			topHeadlinesQueriesSubject.send(nil)
		}

		/// Delete all source entities
		try backgroundContext.performAndWait {
			let sourcesFetchRequest = SourceEntity.fetchRequest()
			let sources = try backgroundContext.fetch(sourcesFetchRequest)
			sources.forEach { source in
				backgroundContext.delete(source)
			}
			try backgroundContext.save()
			topHeadlinesSourcesQueriesSubject.send(nil)
		}
	}

	func fetchRequest(country: String) {
		backgroundContext.performAndWait {
			do {
				let fetchRequest = ArticleEntity.fetchRequest()
				fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ArticleEntity.publishedAt,
																 ascending: false)]
				fetchRequest.predicate = NSPredicate(format: "country == %@", country)
				let result = try backgroundContext.fetch(fetchRequest)
				let topHeadlines = TopHeadlines(articles: result.compactMap { $0.toDomain() },
												status: nil,
												totalResults: result.count)
				topHeadlinesQueriesSubject.send(topHeadlines)
			} catch {
				topHeadlinesQueriesSubject.send(nil)
			}
		}
	}

	func fetchSourcesRequest() {
		backgroundContext.performAndWait {
			do {
				let fetchRequest = SourceEntity.fetchRequest()
				fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SourceEntity.id,
																 ascending: true)]
				let result = try backgroundContext.fetch(fetchRequest)
				let sources = Sources(sources: result.compactMap { $0.toDomain() },
									  status: nil)
				topHeadlinesSourcesQueriesSubject.send(sources)
			} catch {
				topHeadlinesSourcesQueriesSubject.send(nil)
			}
		}
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
		backgroundContext.performAndWait {
			do {
				try topHeadlinesDto.articles?.forEach { articleDto in
					guard articleDto.title?.isEmpty == false else { return }
					let articles = try backgroundContext.fetch(ArticleEntity.fetchRequest())
					var article = articles.filter { $0.title == articleDto.title }.first
					if article == nil {
						/// Create article if not existing
						articleDto.toEntity(country: country,
											in: backgroundContext)
					} else {
						/// Update article if existing
						article?.author = articleDto.author
						article?.content = articleDto.content
						article?.country = country
						article?.publishedAt = articleDto.publishedAt?.toDate
						article?.source?.category = articleDto.source?.category
						article?.source?.country = articleDto.source?.country
						article?.source?.id = articleDto.source?.id
						article?.source?.language = articleDto.source?.language
						article?.source?.name = articleDto.source?.name
						article?.source?.story = articleDto.source?.story
						article?.source?.url = articleDto.source?.url
						article?.story = articleDto.story
						article?.title = articleDto.title
						article?.url = articleDto.url
						article?.urlToImage = articleDto.urlToImage
					}
				}
				try backgroundContext.save()
				fetchRequest(country: country)
			} catch {
				topHeadlinesQueriesSubject.send(nil)
			}
		}
	}

	func saveSources(sourcesDto: SourcesDTO) {
		backgroundContext.performAndWait {
			do {
				try sourcesDto.sources?.forEach { sourceDto in
					guard sourceDto.country?.isEmpty == false else { return }
					let sources = try backgroundContext.fetch(SourceEntity.fetchRequest())
					var source = sources.filter { $0.id == sourceDto.id }.first
					if source == nil {
						/// Create source if not existing
						sourceDto.toEntity(in: backgroundContext)
					} else {
						/// Update source if existing
						source?.category = sourceDto.category
						source?.country = sourceDto.country
						source?.id = sourceDto.id
						source?.language = sourceDto.language
						source?.name = sourceDto.name
						source?.story = sourceDto.story
						source?.url = sourceDto.url
					}
				}
				try backgroundContext.save()
				fetchSourcesRequest()
			} catch {
				topHeadlinesSourcesQueriesSubject.send(nil)
			}
		}
	}
}
