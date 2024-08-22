//
//  Date+Extension.swift
//  BobbysNews
//
//  Created by Burak Erol on 02.09.23.
//

import Foundation

extension Date {
    // MARK: - Private Properties

    private static let relativeDateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.timeZone = .current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()

    // MARK: - Properties

    /// Formats date to string in a relative form -> `Yesterday`, `Today`, `Tomorrow`...
    var toRelative: String {
        Date.relativeDateFormatter.string(from: self)
    }
}
