//
//  SourceDTO+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import CoreData

struct SourceDTO: Decodable {

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

extension SourceDTO {

	// MARK: - Mapping

	func toDomain() -> Source? {
		Source(category: category,
			   country: country,
			   id: id,
			   language: language,
			   name: name,
			   story: story,
			   url: url)
	}
}

extension SourceDTO {

	// MARK: - Mapping

	@discardableResult
	func toEntity(in context: NSManagedObjectContext) -> SourceEntity? {
		if id?.localizedStandardContains("removed") == false,
		   name?.localizedStandardContains("removed") == false {
			let entity = SourceEntity(context: context)
			entity.category = category
			entity.country = country
			entity.id = id
			entity.language = language
			entity.name = name
			entity.story = story
			entity.url = url
			return entity
		}
		return nil
	}
}
