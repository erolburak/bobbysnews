//
//  TopHeadlinesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

public final class TopHeadlinesPersistenceControllerMock: PTopHeadlinesPersistenceController {
    // MARK: - Methods

    public func delete() {}

    public func read(category _: String,
                     country _: String) -> [ArticleDB]
    {
        var entity = EntityMock()
        return entity.topHeadlinesDB.filter {
            $0.category == "Test" &&
                $0.country == "Test"
        }
    }

    public func save(category _: String,
                     country _: String,
                     topHeadlinesAPI _: TopHeadlinesAPI) {}
}
