//
//  SourceEntity+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import CoreData

extension SourceEntity {

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
