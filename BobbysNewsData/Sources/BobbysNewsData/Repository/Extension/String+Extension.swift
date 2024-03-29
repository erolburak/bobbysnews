//
//  String+Extension.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 03.09.23.
//

import Foundation

extension String {

	// MARK: - Properties

	/// Formats string to date
	var toDate: Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = .current
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		return dateFormatter.date(from: self)
	}
}
