//
//  Source.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 01.09.23.
//

import Foundation

public struct Source: Hashable, Sendable {

	// MARK: - Properties

	public let category: String?
	public let country: String?
	public let id: String?
	public let language: String?
	public let name: String?
	public let story: String?
	public let url: URL?

	// MARK: - Inits

	public init(category: String?,
				country: String?,
				id: String?,
				language: String?,
				name: String?,
				story: String?,
				url: URL?) {
		self.category = category
		self.country = country
		self.id = id
		self.language = language
		self.name = name
		self.story = story
		self.url = url
	}
}
