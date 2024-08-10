//
//  SourcesAPI.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 05.09.23.
//

public struct SourcesAPI: Decodable, Sendable {

	// MARK: - Properties

	public let sources: [SourceAPI]?
}
