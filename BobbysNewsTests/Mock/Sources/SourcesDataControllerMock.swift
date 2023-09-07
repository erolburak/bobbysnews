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

	var queriesSubject: CurrentValueSubject<Sources?, Never> = CurrentValueSubject(EntityMock.sources1)

	// MARK: - Actions

	func delete() throws {
		queriesSubject.send(nil)
	}

	func fetchRequest() {
		queriesSubject.send(EntityMock.sources1)
	}

	func read() -> AnyPublisher<Sources, Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(sourcesDto: SourcesDTO) {
		var sources: [Source] = []
		sourcesDto.sources?.forEach { sourceDto in
			guard queriesSubject.value?.sources?.filter({ $0.id == sourceDto.id }).isEmpty == true,
				  sourceDto.name?.isEmpty == false,
				  let source = sourceDto.toDomain() else { return }
			sources.append(source)
		}
		queriesSubject.send(Sources(sources: sources + (EntityMock.sources1.sources ?? []),
									status: sourcesDto.status))
	}
}
