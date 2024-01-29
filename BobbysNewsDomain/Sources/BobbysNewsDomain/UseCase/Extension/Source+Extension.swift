//
//  Source+Extension.swift
//	BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

import BobbysNewsData

extension Source {

	// MARK: - Inits

	init?(from db: SourceDB?) {
		guard let db else {
			return nil
		}
		self.init(category: db.category,
				  country: db.country,
				  id: db.id,
				  language: db.language,
				  name: db.name,
				  story: db.story,
				  url: db.url)
	}
}
