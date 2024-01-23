//
//  SourcesApi.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

struct SourcesApi: Decodable {

	// MARK: - Properties

	let sources: [SourceApi]?
	let status: String?
}
