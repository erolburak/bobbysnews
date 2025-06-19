//
//  ArticleDB+Extension.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

extension ArticleDB {
    // MARK: - Lifecycles

    @discardableResult
    public convenience init(
        from api: ArticleAPI,
        category: String,
        country: String
    ) {
        self.init(context: PersistenceController.shared.backgroundContext)
        self.category = category
        content = api.content
        self.country = country
        image = api.image
        publishedAt = api.publishedAt
        if let sourceAPI = api.source {
            source = SourceDB(from: sourceAPI)
        }
        story = api.story
        title = api.title
        url = api.url
    }
}
