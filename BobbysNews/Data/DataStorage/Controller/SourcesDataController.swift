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
	func save(sourcesDto: SourcesDTO)
}

class SourcesDataController: PSourcesDataController {

	// MARK: - Properties

	static let shared = SourcesDataController()

	// MARK: - Private Properties

	internal let queriesSubject: CurrentValueSubject<Sources?, Never> = CurrentValueSubject(nil)
	private let backgroundContext = DataController.shared.backgroundContext

	// MARK: - Actions

	func delete() throws {
		try backgroundContext.executeAndMergeChanges(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "SourceEntity")))
		queriesSubject.send(nil)
	}

	func fetchRequest() {
		backgroundContext.performAndWait {
			do {
				let fetchRequest = SourceEntity.fetchRequest()
				fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SourceEntity.id,
																 ascending: true)]
				let result = try backgroundContext.fetch(fetchRequest)
				let sources = Sources(sources: result.compactMap { $0.toDomain() },
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

	func save(sourcesDto: SourcesDTO) {
		backgroundContext.performAndWait {
			do {
				try sourcesDto.sources?.forEach { sourceDto in
					guard sourceDto.country?.isEmpty == false else { return }
					let sources = try backgroundContext.fetch(SourceEntity.fetchRequest())
					let source = sources.filter { $0.id == sourceDto.id }.first
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
			} catch {
				queriesSubject.send(nil)
			}
		}
		fetchRequest()
	}
}
