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
		category = api.category
		country = api.country
		id = api.id
		language = api.language
		name = api.name
		story = api.story
		url = api.url
	}
}
