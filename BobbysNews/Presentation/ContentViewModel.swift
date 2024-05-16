//
//  ContentViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

@preconcurrency
import BobbysNewsDomain
import Combine
import TipKit

@Observable
final class ContentViewModel: Sendable {

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

		var image: Image? = Image(systemName: "gearshape.circle.fill")
		var message: Text? = Text("SettingsTipMessage")
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

	// MARK: - Private Properties

	private var cancellables = Set<AnyCancellable>()

	// MARK: - Properties

	var alertError: Errors?
	var apiKeyTotalAmount = 5
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
	var settingsTip = SettingsTip()
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
#if DEBUG
		return
#else
		configureTipKit()
#endif
	}

	func onAppear(selectedCountry: String) {
		self.selectedCountry = selectedCountry
		readSources()
		readTopHeadlines()
	}

	func onDisappear() {
		cancellables.removeAll()
	}

	func fetchSources(sensoryFeedback: Bool? = nil) async {
		stateSources = .isLoading
		do {
			try await fetchSourcesUseCase
				.fetch(apiKey: apiKeyVersion)
		} catch {
			updateStateSources(completion: .failure(error),
							   state: countries?.isEmpty == true ? .emptyFetch : .loaded)
		}
	}

	func fetchTopHeadlines(state: StateTopHeadlines? = nil) async {
		if !selectedCountry.isEmpty {
			if let state {
				stateTopHeadlines = state
			}
			do {
				try await fetchTopHeadlinesUseCase
					.fetch(apiKey: apiKeyVersion,
						   country: selectedCountry)
			} catch {
				updateStateTopHeadlines(completion: .failure(error),
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
			try deleteSourcesUseCase
				.delete()
			/// Delete all persisted topHeadlines
			try deleteTopHeadlinesUseCase
				.delete()
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

	private func configureTipKit() {
		Task {
			try? Tips.configure([.displayFrequency(.immediate),
								 .datastoreLocation(.groupContainer(identifier: "com.burakerol.BobbysNews"))])
		}
	}

	private func readSources() {
		readSourcesUseCase
			.read()
			.compactMap { $0.sources }
			.receive(on: DispatchWorkloop.main)
			.sink(receiveCompletion: { [weak self] completion in
				if case .failure = completion {
					self?.updateStateSources(completion: completion,
											 state: .emptyRead)
				}
			}, receiveValue: { [weak self] sources in
				/// Set of unique countries
				let countries = Set(sources.compactMap { $0.country == "zh" ? "cn" : $0.country })
					.sorted(by: { lhs, rhs in
						Locale.current.localizedString(forRegionCode: lhs) ?? "" <= Locale.current.localizedString(forRegionCode: rhs) ?? ""})
				self?.countries = countries
				self?.updateStateSources(completion: .finished,
										 state: countries.isEmpty ? self?.stateSources == .emptyFetch ? .emptyFetch : .emptyRead : .loaded)
			})
			.store(in: &cancellables)
	}

	private func readTopHeadlines() {
		readTopHeadlinesUseCase
			.read()
			.compactMap { $0.articles }
			.receive(on: DispatchWorkloop.main)
			.sink(receiveCompletion: { [weak self] completion in
				if case .failure = completion {
					self?.updateStateTopHeadlines(completion: completion,
												  state: .emptyRead)
				}
			}, receiveValue: { [weak self] articles in
				self?.articles = articles
				self?.updateStateTopHeadlines(completion: .finished,
											  state: articles.isEmpty ? self?.stateTopHeadlines == .emptyFetch ? .emptyFetch : .emptyRead : .loaded)
			})
			.store(in: &cancellables)
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

	private func updateStateSources(completion: Subscribers.Completion<Error>,
									state: StateSources) {
		switch completion {
		case .finished:
			stateSources = state
		case .failure(let error):
			stateSources = state
			showAlert(error: error as? Errors ?? .error(error.localizedDescription))
		}
	}

	private func updateStateTopHeadlines(completion: Subscribers.Completion<Error>,
										 state: StateTopHeadlines) {
		switch completion {
		case .finished:
			stateTopHeadlines = state
		case .failure(let error):
			stateTopHeadlines = state
			showAlert(error: error as? Errors ?? .error(error.localizedDescription))
		}
	}
}
