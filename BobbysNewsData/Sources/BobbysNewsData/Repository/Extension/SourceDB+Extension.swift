//
//  SourceDB+Extension.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

public extension SourceDB {
    // MARK: - Lifecycles

    @discardableResult
    convenience init(from api: SourceAPI) {
        self.init(context: PersistenceController.shared.backgroundContext)
        category = api.category
        country = api.country
        id = api.id
        language = api.language
        name = api.name
        story = api.story
        url = api.url
    }
}
