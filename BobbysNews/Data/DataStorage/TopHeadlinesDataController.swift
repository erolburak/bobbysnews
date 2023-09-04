//
//  TopHeadlinesDataController.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine
import CoreData

protocol PTopHeadlinesDataController {
	var topHeadlinesQueriesSubject: CurrentValueSubject<TopHeadlines?, Never> { get }
	func delete() throws
	func fetchRequest(country: Country)
	func read() -> AnyPublisher<TopHeadlines, Error>
	func save(country: Country,
			  topHeadlinesDto: TopHeadlinesDTO)
}

class TopHeadlinesDataController: PTopHeadlinesDataController {

	// MARK: - Properties

	static let shared = TopHeadlinesDataController()

	// MARK: - Private Properties

	internal let topHeadlinesQueriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(nil)
	private let backgroundContext = DataController.shared.backgroundContext

	// MARK: - Actions

	func delete() throws {
		try backgroundContext.performAndWait {
			let fetchRequest = ArticleEntity.fetchRequest()
			let articles = try backgroundContext.fetch(fetchRequest)
			articles.forEach { article in
				backgroundContext.delete(article)
			}
			try backgroundContext.save()
			self.fetchRequest()
		}
	}

	func fetchRequest(country: Country = .none) {
		backgroundContext.performAndWait {
			do {
				let fetchRequest = ArticleEntity.fetchRequest()
				fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ArticleEntity.publishedAt,
																 ascending: false)]
				fetchRequest.predicate = NSPredicate(format: "country == %@", country.rawValue)
				let articles = try backgroundContext.fetch(fetchRequest)
				let topHeadlines = TopHeadlines(articles: articles.map { $0.toDomain() },
												status: nil,
												totalResults: articles.count)
				topHeadlinesQueriesSubject.send(topHeadlines)
			} catch {
				topHeadlinesQueriesSubject.send(nil)
			}
		}
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		topHeadlinesQueriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: Country,
			  topHeadlinesDto: TopHeadlinesDTO) {
		backgroundContext.performAndWait {
			do {
				try topHeadlinesDto.articles?.forEach { articleDto in
					guard try backgroundContext.fetch(ArticleEntity.fetchRequest()).filter({ $0.title == articleDto.title }).isEmpty == true else { return }
					articleDto.toEntity(country: country,
										in: backgroundContext)
				}
				try backgroundContext.save()
				fetchRequest(country: country)
			} catch {
				topHeadlinesQueriesSubject.send(nil)
			}
		}
	}
}
