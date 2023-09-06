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

	/// Mocks which represent existing ones
	static let articleDto1 = ArticleDTO(author: "Test 1",
										content: "Test 1",
										publishedAt: "2001-02-03T12:34:56Z",
										source: sourceDto1,
										story: "Test 1",
										title: "Test 1",
										url: URL(string: "Test 1"),
										urlToImage: URL(string: "Test 1"))
	static let articleDto2 = ArticleDTO(author: "Test 2",
										content: "Test 2",
										publishedAt: "2001-02-03T12:34:56Z",
										source: sourceDto2,
										story: "Test 2",
										title: "Test 2",
										url: URL(string: "Test 2"),
										urlToImage: URL(string: "Test 2"))
	static let sourceDto1 = SourceDTO(category: "Test 1",
									  country: "Test 1",
									  id: "Test 1",
									  language: "Test 1",
									  name: "Test 1",
									  story: "Test 1",
									  url: URL(string: "Test 1"))
	static let sourceDto2 = SourceDTO(category: "Test 2",
									  country: "Test 2",
									  id: "Test 2",
									  language: "Test 2",
									  name: "Test 2",
									  story: "Test 2",
									  url: URL(string: "Test 2"))
	static let sourcesDto1 = SourcesDTO(sources: [sourceDto1,
												  sourceDto2],
										status: "Test 1")
	static let topHeadlinesDto1 = TopHeadlinesDTO(articles: [articleDto1,
															 articleDto2],
												  status: "Test 1",
												  totalResults: 2)

	/// Mocks which represent new ones
	static let articleDto3 = ArticleDTO(author: "Test 3",
										content: "Test 3",
										publishedAt: "2001-02-03T12:34:56Z",
										source: sourceDto3,
										story: "Test 3",
										title: "Test 3",
										url: URL(string: "Test 3"),
										urlToImage: URL(string: "Test 3"))
	static let articleDto4 = ArticleDTO(author: "Test 4",
										content: "Test 4",
										publishedAt: "2001-02-03T12:34:56Z",
										source: sourceDto4,
										story: "Test 4",
										title: "Test 4",
										url: URL(string: "Test 4"),
										urlToImage: URL(string: "Test 4"))
	static let sourceDto3 = SourceDTO(category: "Test 3",
									  country: "Test 3",
									  id: "Test 3",
									  language: "Test 3",
									  name: "Test 3",
									  story: "Test 3",
									  url: URL(string: "Test 3"))
	static let sourceDto4 = SourceDTO(category: "Test 4",
									  country: "Test 4",
									  id: "Test 4",
									  language: "Test 4",
									  name: "Test 4",
									  story: "Test 4",
									  url: URL(string: "Test 4"))
	static let sourcesDto2 = SourcesDTO(sources: [sourceDto3,
												  sourceDto4],
										status: "Test 2")
	static let topHeadlinesDto2 = TopHeadlinesDTO(articles: [articleDto3,
															 articleDto4],
												  status: "Test 2",
												  totalResults: 2)
}
