//
//  DTOMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 06.09.23.
//

@testable import BobbysNews
import Foundation

struct DTOMock {

	// MARK: - Properties

	static let articleDto = ArticleDTO(author: "Test",
									   content: "Test",
									   publishedAt: "Test",
									   source: sourceDto,
									   story: "Test",
									   title: "Test",
									   url: URL(string: "Test"),
									   urlToImage: URL(string: "Test"))
	static let sourceDto = SourceDTO(category: "Test",
									 country: "Test",
									 id: "Test",
									 language: "Test",
									 name: "Test",
									 story: "Test",
									 url: URL(string: "Test"))
	static let sourcesDto = SourcesDTO(sources: [sourceDto,
												 sourceDto],
									   status: "Test")
	static let topHeadlinesDto = TopHeadlinesDTO(articles: [articleDto,
															articleDto],
												 status: "Test",
												 totalResults: 2)
}
