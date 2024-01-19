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

	var queriesSubject: CurrentValueSubject<TopHeadlines?, Never> { get }

	// MARK: - Actions

	func delete(country: String?) throws
	func fetchRequest(country: String)
	func read() -> AnyPublisher<TopHeadlines, Error>
	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO)
}

class TopHeadlinesDataController: PTopHeadlinesDataController {

	// MARK: - Properties

	static let shared = TopHeadlinesDataController()

	// MARK: - Private Properties

	internal let queriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(nil)
	private let backgroundContext = DataController.shared.backgroundContext

	// MARK: - Actions

	func delete(country: String?) throws {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
		if let country {
			fetchRequest.predicate = NSPredicate(format: "country == %@", country)
		}
		try backgroundContext.execute(NSBatchDeleteRequest(fetchRequest: fetchRequest))
		try backgroundContext.save()
		queriesSubject.send(nil)
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
				queriesSubject.send(topHeadlines)
			} catch {
				queriesSubject.send(nil)
			}
		}
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO) {
		backgroundContext.performAndWait {
			do {
				try topHeadlinesDto.articles?.forEach { articleDto in
					guard articleDto.title?.isEmpty == false else {
						return
					}
					let articles = try backgroundContext.fetch(ArticleEntity.fetchRequest())
					let article = articles.filter { $0.title == articleDto.title }.first
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
			} catch {
				queriesSubject.send(nil)
			}
		}
		fetchRequest(country: country)
	}
}
