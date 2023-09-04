//
//  SourceDTO+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

struct SourceDTO: Decodable {

	// MARK: - Properties

	let id: String?
	let name: String?
}

extension SourceDTO {

	// MARK: - Mapping

	func toDomain() -> Source {
		Source(id: id,
			   name: name)
	}
}
