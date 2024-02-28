//
//  Sources.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

public struct Sources: Sendable {

	// MARK: - Properties

	public let sources: [Source]?

	// MARK: - Inits

	public init(sources: [Source]?) {
		self.sources = sources
	}
}
