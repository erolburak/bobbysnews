//
//  ArticleEntity+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 01.09.23.
//

import CoreData

extension ArticleEntity {

	// MARK: - Mapping

	func toDomain() -> Article? {
		Article(author: author,
				content: content,
				country: country,
				publishedAt: publishedAt,
				source: source?.toDomain(),
				story: story,
				title: title,
				url: url,
				urlToImage: urlToImage)
	}
}
