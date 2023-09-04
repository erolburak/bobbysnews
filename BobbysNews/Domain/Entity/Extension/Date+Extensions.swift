//
//  Date+Extensions.swift
//  BobbysNews
//
//  Created by Burak Erol on 02.09.23.
//

import Foundation

extension Date {

	// MARK: - Properties

	/// Formats date to string in a relative form -> `Yesterday`, `Today`, `Tomorrow`...
	var toRelative: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .short
		dateFormatter.doesRelativeDateFormatting = true
		return dateFormatter.string(from: self)
	}
}
