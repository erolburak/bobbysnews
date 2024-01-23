//
//  SourcesDataControllerMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews
import Combine

class SourcesDataControllerMock: PSourcesDataController {

	// MARK: - Properties

	var queriesSubject: CurrentValueSubject<Sources?, Never> = CurrentValueSubject(EntityMock.sourcesEntity)

	// MARK: - Actions

	func delete() throws {
		queriesSubject.send(nil)
	}

	func fetchRequest() {
		queriesSubject.send(EntityMock.sourcesEntity)
	}

	func read() -> AnyPublisher<Sources, Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(sourcesApi: SourcesApi) {
		var sources: [Source] = []
		sourcesApi.sources?.forEach { sourceApi in
			guard queriesSubject.value?.sources?.filter({ $0.id == sourceApi.id }).isEmpty == true,
				  sourceApi.name?.isEmpty == false else {
				return
			}
			sources.append(Source(category: sourceApi.category,
								  country: sourceApi.country,
									 id: sourceApi.id,
									 language: sourceApi.language,
									 name: sourceApi.name,
									 story: sourceApi.story,
									 url: sourceApi.url))
		}
		queriesSubject.send(Sources(sources: sources + (EntityMock.sourcesEntity?.sources ?? []),
									status: sourcesApi.status))
	}
}
