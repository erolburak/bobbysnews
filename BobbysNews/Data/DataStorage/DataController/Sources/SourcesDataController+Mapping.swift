//
//  SourcesDataController+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.01.24.
//

import CoreData

extension Source {

	// MARK: - Inits

	init?(from entity: SourceEntity?) {
		guard let entity else { return nil }
		self.init(category: entity.category,
				  country: entity.country,
				  id: entity.id,
				  language: entity.language,
				  name: entity.name,
				  story: entity.story,
				  url: entity.url)
	}
}

extension SourceEntity {

	// MARK: - Inits

	@discardableResult
	convenience init?(from api: SourceApi?,
					  in context: NSManagedObjectContext) {
		guard let api,
			  api.id?.localizedStandardContains("removed") == false,
			  api.name?.localizedStandardContains("removed") == false else { return nil }
		self.init(context: context)
		self.category = api.category
		self.country = api.country
		self.id = api.id
		self.language = api.language
		self.name = api.name
		self.story = api.story
		self.url = api.url
	}
}
