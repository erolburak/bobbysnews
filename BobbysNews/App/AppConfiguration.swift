//
//  AppConfiguration.swift
//  BobbysNews
//
//  Created by Burak Erol on 01.09.23.
//

import Foundation

struct AppConfiguration {

	// MARK: - Type Definitions

	enum Errors: Equatable, LocalizedError {

		// MARK: - Properties

		case delete, error(String), fetchTopHeadlines

		static var allCases: [Errors] = [.delete,
										 .error("Error\("ErrorDescription")"),
										 .fetchTopHeadlines]

		var errorDescription: String? {
			switch self {
			case .delete: 
				return String(localized: "Error\("ErrorDescriptionDelete")")
			case .error(let error):
				return error.description
			case .fetchTopHeadlines:
				return String(localized: "Error\("ErrorDescriptionFetchTopHeadlines")")
			}
		}

		var recoverySuggestion: String? {
			switch self {
			case .delete: 
				return String(localized: "ErrorRecoverySuggestionDelete")
			case .error:
				return String(localized: "ErrorRecoverySuggestion")
			case .fetchTopHeadlines: 
				return String(localized: "ErrorRecoverySuggestionFetchTopHeadlines")
			}
		}
	}

	// MARK: - Properties

	static let apiBaseUrl = {
		guard let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ApiBaseUrl") as? String else {
			fatalError("ApiBaseUrl is missing")
		}
		return apiBaseUrl
	}()

	static let apiKey = {
		guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
			fatalError("ApiKey is missing")
		}
		return apiKey
	}()
}
