//
//  ContentViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import TipKit

@MainActor
@Observable
final class ContentViewModel {

	// MARK: - Type Definitions

	enum StateSources {
		/// General States
		case isLoading, loaded
		/// Empty States
		case emptyFetch, emptyRead
	}

	enum StateTopHeadlines {
		/// General States
		case isLoading, loaded
		/// Empty States
		case emptyFetch, emptyRead
	}

	struct SettingsTip: Tip {

		// MARK: - Properties

		@Parameter
		static var show: Bool = false
		var image: Image? = Image(systemName: "gearshape.circle.fill")
		var message: Text? = Text("SettingsTipMessage")
		var rules: [Rule] {
			[#Rule(Self.$show) {
				$0 == true
			}]
		}
		var title = Text("Settings")
	}

	// MARK: - Use Cases

	/// Sources
	private let deleteSourcesUseCase: PDeleteSourcesUseCase
	private let fetchSourcesUseCase: PFetchSourcesUseCase
	private let readSourcesUseCase: PReadSourcesUseCase
	/// TopHeadlines
	private let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
	private let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
	private let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase

	// MARK: - Properties

	let apiKeyTotalAmount = 5
	let settingsTip = SettingsTip()
	var alertError: Errors?
	var apiKeyVersion = 1 {
		didSet {
			sensoryFeedbackTrigger(feedback: .selection)
		}
	}
	var articles: [Article]?
	var countries: [String]?
	var listDisabled: Bool { stateTopHeadlines != .loaded }
	var listOpacity: Double { stateTopHeadlines == .loaded ? 1 : 0.3 }
	var selectedCountry = "" {
		willSet {
			if !newValue.isEmpty {
				sensoryFeedbackTrigger(feedback: .selection)
			}
		}
	}
	var sensoryFeedback: SensoryFeedback?
	var sensoryFeedbackBool = false
	var showAlert = false
	var showConfirmationDialog = false
	var stateSources: StateSources = .isLoading
	var stateTopHeadlines: StateTopHeadlines = .isLoading

	// MARK: - Inits

	init(deleteSourcesUseCase: PDeleteSourcesUseCase,
		 fetchSourcesUseCase: PFetchSourcesUseCase,
		 readSourcesUseCase: PReadSourcesUseCase,
		 deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase,
		 fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase,
		 readTopHeadlinesUseCase: PReadTopHeadlinesUseCase) {
		self.deleteSourcesUseCase = deleteSourcesUseCase
		self.fetchSourcesUseCase = fetchSourcesUseCase
		self.readSourcesUseCase = readSourcesUseCase
		self.deleteTopHeadlinesUseCase = deleteTopHeadlinesUseCase
		self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
		self.readTopHeadlinesUseCase = readTopHeadlinesUseCase
		configureTipKit()
	}

	func onAppear(selectedCountry: String) {
		self.selectedCountry = selectedCountry
		readSources()
		readTopHeadlines()
	}

	func fetchSources(sensoryFeedback: Bool? = nil) async {
		stateSources = .isLoading
		do {
			try await fetchSourcesUseCase.fetch(apiKey: apiKeyVersion)
			readSources()
		} catch {
			updateStateSources(error: error,
							   state: countries?.isEmpty == true ? .emptyFetch : .loaded)
		}
	}

	func fetchTopHeadlines(state: StateTopHeadlines? = nil) async {
		if !selectedCountry.isEmpty {
			if let state {
				stateTopHeadlines = state
			}
			do {
				try await fetchTopHeadlinesUseCase.fetch(apiKey: apiKeyVersion,
														 country: selectedCountry)
				readTopHeadlines()
			} catch {
				updateStateTopHeadlines(error: error,
										state: articles?.isEmpty == true ? .emptyFetch : .loaded)
			}
		}
	}

	func invalidateSettingsTip() {
		settingsTip.invalidate(reason: .actionPerformed)
	}

	func reset() {
		do {
			/// Delete all persisted sources
			try deleteSourcesUseCase.delete()
			/// Delete all persisted topHeadlines
			try deleteTopHeadlinesUseCase.delete()
			apiKeyVersion = 1
			articles = nil
			countries = nil
			selectedCountry = ""
			stateSources = .emptyRead
			stateTopHeadlines = .emptyRead
			sensoryFeedbackTrigger(feedback: .success)
		} catch {
			showAlert(error: .reset)
		}
	}

	func showSettingsTip() throws {
		SettingsTip.show = true
	}

	private func configureTipKit() {
		try? Tips.configure([.displayFrequency(.immediate),
							 .datastoreLocation(.groupContainer(identifier: "com.burakerol.BobbysNews"))])
	}

	private func readSources() {
		do {
			guard let sources = try readSourcesUseCase.read().sources else {
				throw Errors.read
			}
			/// Set of unique countries
			let countries = Set(sources.compactMap { $0.country == "zh" ? "cn" : $0.country })
				.sorted(by: { lhs, rhs in
					Locale.current.localizedString(forRegionCode: lhs) ?? "" <= Locale.current.localizedString(forRegionCode: rhs) ?? ""})
			self.countries = countries
			updateStateSources(state: countries.isEmpty ? stateSources == .emptyFetch ? .emptyFetch : .emptyRead : .loaded)
		} catch {
			updateStateSources(error: error,
							   state: .emptyRead)
		}
	}

	private func readTopHeadlines() {
		do {
			guard let articles = try readTopHeadlinesUseCase.read(country: selectedCountry).articles else {
				throw Errors.read
			}
			self.articles = articles
			updateStateTopHeadlines(state: articles.isEmpty ? stateTopHeadlines == .emptyFetch ? .emptyFetch : .emptyRead : .loaded)
		} catch {
			updateStateTopHeadlines(error: error,
									state: .emptyRead)
		}
	}

	private func sensoryFeedbackTrigger(feedback: SensoryFeedback) {
		sensoryFeedback = feedback
		sensoryFeedbackBool.toggle()
	}

	private func showAlert(error: Errors) {
		alertError = error
		showAlert = true
		sensoryFeedbackTrigger(feedback: .error)
	}

	private func updateStateSources(error: Error? = nil,
									state: StateSources) {
		guard let error else {
			return stateSources = state
		}
		stateSources = state
		showAlert(error: error as? Errors ?? .error(error.localizedDescription))
	}

	private func updateStateTopHeadlines(error: Error? = nil,
										 state: StateTopHeadlines) {
		guard let error else {
			return stateTopHeadlines = state
		}
		stateTopHeadlines = state
		showAlert(error: error as? Errors ?? .error(error.localizedDescription))
	}
}
