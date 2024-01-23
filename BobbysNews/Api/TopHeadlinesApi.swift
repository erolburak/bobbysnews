//
//  TopHeadlinesApi.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

struct TopHeadlinesApi: Decodable {

	// MARK: - Properties

	let articles: [ArticleApi]?
	let status: String?
	let totalResults: Int?
}
