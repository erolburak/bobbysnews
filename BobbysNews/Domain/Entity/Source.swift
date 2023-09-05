//
//  Source.swift
//  BobbysNews
//
//  Created by Burak Erol on 01.09.23.
//

import Foundation

struct Source: Hashable {

	// MARK: - Properties

	let category: String?
	let country: String?
	let id: String?
	let language: String?
	let name: String?
	let story: String?
	let url: URL?
}
