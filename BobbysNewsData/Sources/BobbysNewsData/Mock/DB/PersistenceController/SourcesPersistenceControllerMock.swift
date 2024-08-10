//
//  SourcesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

public final class SourcesPersistenceControllerMock: PSourcesPersistenceController {

	// MARK: - Actions

	public func delete() {}

	public func read() -> [SourceDB] {
		var entity = EntityMock()
		return entity.sourcesDB
	}

	public func save(sourcesAPI: SourcesAPI) {}
}
