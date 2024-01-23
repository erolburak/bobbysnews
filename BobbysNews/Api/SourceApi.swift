//
//  SourceApi.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

struct SourceApi: Decodable {

	// MARK: - Properties

	let category: String?
	let country: String?
	let id: String?
	let language: String?
	let name: String?
	let story: String?
	let url: URL?

	// MARK: - Private Properties

	private enum CodingKeys: String, CodingKey {
		case category, country, id, language, name, url
		case story = "description"
	}
}
