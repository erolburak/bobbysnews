//
//  SourcesPersistenceController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

import CoreData

public protocol PSourcesPersistenceController: Sendable {

	// MARK: - Actions

	func delete() throws
	func read() throws -> [SourceDB]
	func save(sourcesAPI: SourcesAPI) throws
}

final class SourcesPersistenceController: PSourcesPersistenceController {

	// MARK: - Actions

	func delete() throws {
		try PersistenceController.shared.backgroundContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "SourceDB")))
		try PersistenceController.shared.backgroundContext.save()
	}

	func read() throws -> [SourceDB] {
		try PersistenceController.shared.backgroundContext.performAndWait {
			let fetchRequest = SourceDB.fetchRequest()
			fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SourceDB.id,
															 ascending: true)]
			return try PersistenceController.shared.backgroundContext.fetch(fetchRequest)
		}
	}

	func save(sourcesAPI: SourcesAPI) throws {
		try PersistenceController.shared.backgroundContext.performAndWait {
			let existingSources = try PersistenceController.shared.backgroundContext.fetch(SourceDB.fetchRequest())
			sourcesAPI.sources?.forEach { sourceAPI in
				guard sourceAPI.country?.isEmpty == false else {
					return
				}
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
			try PersistenceController.shared.backgroundContext.save()
		}
	}
}
