//
//  Country.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

enum Country: String, CaseIterable, Comparable {

	// MARK: - Properties

	case germany = "de"
	case unitedKingdom = "gb"
	case unitedStates = "us"
	case none = ""

	// MARK: - Comparable

	static func < (lhs: Country,
				   rhs: Country) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}
