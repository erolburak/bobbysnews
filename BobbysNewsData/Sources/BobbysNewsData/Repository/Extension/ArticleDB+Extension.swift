//
//  ArticleDB+Extension.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

public extension ArticleDB {
    // MARK: - Lifecycles

    @discardableResult
    convenience init(from api: ArticleAPI,
                     country: String)
    {
        self.init(context: PersistenceController.shared.backgroundContext)
        author = api.author
        content = api.content
        self.country = country
        publishedAt = api.publishedAt
        if let sourceAPI = api.source {
            source = SourceDB(from: sourceAPI)
        }
        story = api.story
        title = api.title
        url = api.url
        urlToImage = api.urlToImage
    }
}
