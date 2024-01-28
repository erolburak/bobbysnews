//
//  SourcesPersistenceController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

import Combine
import CoreData

public protocol PSourcesPersistenceController {

	// MARK: - Properties

	var queriesSubject: CurrentValueSubject<[SourceDB]?, Never> { get }

	// MARK: - Actions

	func delete() throws
	func fetchRequest()
	func read() -> AnyPublisher<[SourceDB], Error>
	func save(sourcesAPI: SourcesAPI)
}

class SourcesPersistenceController: PSourcesPersistenceController {

	// MARK: - Private Properties

	internal let queriesSubject: CurrentValueSubject<[SourceDB]?, Never> = CurrentValueSubject(nil)
	private let backgroundContext = PersistenceController.shared.backgroundContext

	// MARK: - Properties

	static let shared = SourcesPersistenceController()

	// MARK: - Actions

	func delete() throws {
		try backgroundContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "SourceDB")))
		try backgroundContext.save()
		queriesSubject.send(nil)
	}

	func fetchRequest() {
		do {
			try backgroundContext.performAndWait {
				let fetchRequest = SourceDB.fetchRequest()
				fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SourceDB.id,
																 ascending: true)]
				queriesSubject.send(try backgroundContext.fetch(fetchRequest))
			}
		} catch {
			queriesSubject.send(nil)
		}
	}

	func read() -> AnyPublisher<[SourceDB], Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(sourcesAPI: SourcesAPI) {
		do {
			try backgroundContext.performAndWait {
				let existingSources = try backgroundContext.fetch(SourceDB.fetchRequest())
				sourcesAPI.sources?.forEach { sourceAPI in
					guard sourceAPI.country?.isEmpty == false else { return }
					let existingSource = existingSources.first { $0.id == sourceAPI.id }
					if existingSource != nil {
						/// Update existing source
						existingSource?.category = sourceAPI.category
						existingSource?.country = sourceAPI.country
						existingSource?.id = sourceAPI.id
						existingSource?.language = sourceAPI.language
						existingSource?.name = sourceAPI.name
						existingSource?.story = sourceAPI.story
						existingSource?.url = sourceAPI.url
					} else {
						/// Create new source
						SourceDB(from: sourceAPI)
					}
				}
				try backgroundContext.save()
			}
			fetchRequest()
		} catch {
			queriesSubject.send(nil)
		}
	}
}
