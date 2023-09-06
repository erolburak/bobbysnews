//
//  EntityMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 06.09.23.
//

@testable import BobbysNews
import Foundation

struct EntityMock {

	// MARK: - Properties

	static let article = Article(author: "Test",
								 content: "Test",
								 country: "Test",
								 publishedAt: Date.now,
								 source: source,
								 story: "Test",
								 title: "Test",
								 url: URL(string: "Test"),
								 urlToImage: URL(string: "Test"))
	static let source = Source(category: "Test",
							   country: "Test",
							   id: "Test",
							   language: "Test",
							   name: "Test",
							   story: "Test",
							   url: URL(string: "Test"))
	static let sources = Sources(sources: [source,
										  source],
								 status: "Test")
	static let topHeadlines = TopHeadlines(articles: [article,
													  article],
										   status: "Test",
										   totalResults: 2)
}
