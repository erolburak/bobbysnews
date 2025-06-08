//
//  Article+Extension.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

import BobbysNewsData

extension Article {
    // MARK: - Lifecycles

    init(from db: ArticleDB) {
        self.init(category: db.category,
                  content: db.content,
                  country: db.content,
                  image: db.image,
                  publishedAt: db.publishedAt,
                  source: Source(from: db.source),
                  story: db.story,
                  title: db.title,
                  url: db.url)
    }
}
