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

		case delete, error(String), fetch, fetchSources, read

		static var allCases: [Errors] = [.delete,
										 .error("Error\("ErrorDescription")"),
										 .fetch,
										 .fetchSources,
										 .read]

		var errorDescription: String? {
			switch self {
			case .delete: 
				return String(localized: "Error\("ErrorDescriptionDelete")")
			case .error(let error):
				return error.description
			case .fetch:
				return String(localized: "Error\("ErrorDescriptionFetch")")
			case .fetchSources:
				return String(localized: "Error\("ErrorDescriptionFetchSources")")
			case .read:
				return String(localized: "Error\("ErrorDescriptionRead")")
			}
		}

		var recoverySuggestion: String? {
			switch self {
			case .delete: 
				return String(localized: "ErrorRecoverySuggestionDelete")
			case .error:
				return String(localized: "ErrorRecoverySuggestion")
			case .fetch:
				return String(localized: "ErrorRecoverySuggestionFetch")
			case .fetchSources:
				return String(localized: "ErrorRecoverySuggestionFetchSources")
			case .read:
				return String(localized: "ErrorRecoverySuggestionRead")
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
