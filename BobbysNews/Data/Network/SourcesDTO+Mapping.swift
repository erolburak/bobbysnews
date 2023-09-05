//
//  SourcesDTO+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

struct SourcesDTO: Decodable {

	// MARK: - Properties

	let sources: [SourceDTO]?
	let status: String?
}

extension SourcesDTO {

	// MARK: - Mapping

	func toDomain() -> Sources? {
		Sources(sources: sources?.compactMap { $0.toDomain() },
				status: status)
	}
}
