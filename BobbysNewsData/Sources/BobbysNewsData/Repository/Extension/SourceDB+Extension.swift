//
//  SourceDB+Extension.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

extension SourceDB {

	// MARK: - Inits

	@discardableResult
	public convenience init(from api: SourceAPI) {
		self.init(context: PersistenceController.shared.backgroundContext)
		self.category = api.category
		self.country = api.country
		self.id = api.id
		self.language = api.language
		self.name = api.name
		self.story = api.story
		self.url = api.url
	}
}
