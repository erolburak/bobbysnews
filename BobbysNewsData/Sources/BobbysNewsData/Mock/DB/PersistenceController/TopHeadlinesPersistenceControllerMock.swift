//
//  TopHeadlinesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

public final class TopHeadlinesPersistenceControllerMock: PTopHeadlinesPersistenceController {
    // MARK: - Methods

    public func delete() {}

    public func read(country: String) -> [ArticleDB] {
        var entity = EntityMock()
        return entity.topHeadlinesDB.filter { $0.country == country }
    }

    public func save(country: String,
                     topHeadlinesAPI: TopHeadlinesAPI) {}
}
