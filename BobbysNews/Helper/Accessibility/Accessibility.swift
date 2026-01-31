//
//  Accessibility.swift
//  BobbysNews
//
//  Created by Burak Erol on 29.01.26.
//

enum Accessibility: String, CaseIterable {
    // MARK: - Properties

    case apiKeyAddEditButton
    case apiKeyAlertConfirmButton
    case closeWebViewButton
    case contentListItem
    case countryPicker
    case emptyApiKey
    case emptyCountry
    case resetButton
    case resetButtonConfirmationDialog
    case settingsMenu
    case shareLink
    case showWebViewButton

    var id: String { rawValue }
}
