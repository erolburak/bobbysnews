//
//  SourcesDataController.swift
//  BobbysNews
//
//  Created by Burak Erol on 07.09.23.
//

import Combine
import CoreData

protocol PSourcesDataController {

	// MARK: - Properties

	var queriesSubject: CurrentValueSubject<Sources?, Never> { get }

	// MARK: - Actions

	func delete() throws
	func fetchRequest()
	func read() -> AnyPublisher<Sources, Error>
	func save(sourcesApi: SourcesApi)
}

class SourcesDataController: PSourcesDataController {

	// MARK: - Properties

	static let shared = SourcesDataController()

	// MARK: - Private Properties

	internal let queriesSubject: CurrentValueSubject<Sources?, Never> = CurrentValueSubject(nil)
	private let backgroundContext = DataController.shared.backgroundContext

	// MARK: - Actions

	func delete() throws {
		try backgroundContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "SourceEntity")))
		try backgroundContext.save()
		queriesSubject.send(nil)
	}

	func fetchRequest() {
		backgroundContext.performAndWait {
			do {
				let fetchRequest = SourceEntity.fetchRequest()
				fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SourceEntity.id,
																 ascending: true)]
				let result = try backgroundContext.fetch(fetchRequest)
				let sources = Sources(sources: result.compactMap { Source(from: $0) },
									  status: nil)
				queriesSubject.send(sources)
			} catch {
				queriesSubject.send(nil)
			}
		}
	}

	func read() -> AnyPublisher<Sources, Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(sourcesApi: SourcesApi) {
		backgroundContext.performAndWait {
			do {
				try sourcesApi.sources?.forEach { sourceApi in
					guard sourceApi.country?.isEmpty == false else {
						return
					}
					let sources = try backgroundContext.fetch(SourceEntity.fetchRequest())
					let source = sources.filter { $0.id == sourceApi.id }.first
					if source == nil {
						/// Create source if not existing
						SourceEntity(from: sourceApi,
									 in: backgroundContext)
					} else {
						/// Update source if existing
						source?.category = sourceApi.category
						source?.country = sourceApi.country
						source?.id = sourceApi.id
						source?.language = sourceApi.language
						source?.name = sourceApi.name
						source?.story = sourceApi.story
						source?.url = sourceApi.url
					}
				}
				try backgroundContext.save()
			} catch {
				queriesSubject.send(nil)
			}
		}
		fetchRequest()
	}
}
