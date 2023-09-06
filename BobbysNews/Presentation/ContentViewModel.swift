//
//  ContentViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Combine
import Foundation

@Observable
class ContentViewModel {

	// MARK: - Type Definitions

	enum StateTopHeadlines {
		/// General States
		case isInitialLoading, isLoading, loaded
		/// Empty States
		case emptyFetch, emptyRead
	}

	enum StateSources {
		/// General States
		case isInitialLoading, isLoading, loaded, load
		/// Empty States
		case emptyFetch, emptyRead
	}

	// MARK: - Use Cases

	/// TopHeadlines
	private let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
	private let fetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase
	private let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
	private let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase
	private let saveTopHeadlinesUseCase: PSaveTopHeadlinesUseCase
	/// Sources
	private let fetchRequestTopHeadlinesSourcesUseCase: PFetchRequestTopHeadlinesSourcesUseCase
	private let fetchTopHeadlinesSourcesUseCase: PFetchTopHeadlinesSourcesUseCase
	private let readTopHeadlinesSourcesUseCase: PReadTopHeadlinesSourcesUseCase
	private let saveTopHeadlinesSourcesUseCase: PSaveTopHeadlinesSourcesUseCase

	// MARK: - Properties

	var alertError: AppConfiguration.Errors?
	var articles: [Article]?
	var countries: [String]?
	var selectedCountry = ""
	var showAlert = false
	var sources: [Source]?
	var stateSources: StateSources = .isInitialLoading
	var stateTopHeadlines: StateTopHeadlines = .isInitialLoading

	// MARK: - Private Properties

	private var cancellable = Set<AnyCancellable>()

	// MARK: - Life Cycle

	init(deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase,
		 fetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase,
		 fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase,
		 readTopHeadlinesUseCase: PReadTopHeadlinesUseCase,
		 saveTopHeadlinesUseCase: PSaveTopHeadlinesUseCase,
		 fetchRequestTopHeadlinesSourcesUseCase: PFetchRequestTopHeadlinesSourcesUseCase,
		 fetchTopHeadlinesSourcesUseCase: PFetchTopHeadlinesSourcesUseCase,
		 readTopHeadlinesSourcesUseCase: PReadTopHeadlinesSourcesUseCase,
		 saveTopHeadlinesSourcesUseCase: PSaveTopHeadlinesSourcesUseCase) {
		self.deleteTopHeadlinesUseCase = deleteTopHeadlinesUseCase
		self.fetchRequestTopHeadlinesUseCase = fetchRequestTopHeadlinesUseCase
		self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
		self.readTopHeadlinesUseCase = readTopHeadlinesUseCase
		self.saveTopHeadlinesUseCase = saveTopHeadlinesUseCase
		self.fetchRequestTopHeadlinesSourcesUseCase = fetchRequestTopHeadlinesSourcesUseCase
		self.fetchTopHeadlinesSourcesUseCase = fetchTopHeadlinesSourcesUseCase
		self.readTopHeadlinesSourcesUseCase = readTopHeadlinesSourcesUseCase
		self.saveTopHeadlinesSourcesUseCase = saveTopHeadlinesSourcesUseCase
	}

	func onAppear(country: String) {
		selectedCountry = country
		/// Load TopHeadlines
		readTopHeadlines()
		fetchRequestTopHeadlines()
		/// Load Sources
		readTopHeadlinesSources()
		fetchRequestTopHeadlinesSources()
		Task {
			await fetchTopHeadlines(state: .isInitialLoading)
			await fetchTopHeadlinesSources(state: .isInitialLoading)
		}
	}

	func onDisappear() {
		cancellable.removeAll()
	}

	func delete() {
		do {
			try deleteTopHeadlinesUseCase
				.delete()
			selectedCountry = ""
			stateSources = .load
			stateTopHeadlines = .emptyRead
		} catch {
			showAlert(error: .delete)
		}
	}

	func fetchTopHeadlines(state: StateTopHeadlines? = nil) async {
		if let state {
			stateTopHeadlines = state
			fetchTopHeadlinesUseCase
				.fetch(country: selectedCountry)
				.sink { [weak self] completion in
					self?.updateStateTopHeadlines(completion: completion,
												  failureState: .emptyFetch)
				} receiveValue: { [weak self] topHeadlinesDto in
					if let country = self?.selectedCountry {
						self?.saveTopHeadlinesUseCase
							.save(country: country,
								  topHeadlinesDto: topHeadlinesDto)
					}
				}
				.store(in: &cancellable)
		}
	}

	func fetchTopHeadlinesSources(state: StateSources? = nil) async {
		if let state {
			stateSources = state
			fetchTopHeadlinesSourcesUseCase
				.fetchSources()
				.sink { [weak self] completion in
					self?.updateStateSources(completion: completion,
											 failureState: .emptyFetch)
				} receiveValue: { [weak self] sourcesDto in
					self?.saveTopHeadlinesSourcesUseCase
						.saveSources(sourcesDto: sourcesDto)
				}
				.store(in: &cancellable)
		}
	}

	func showAlert(error: AppConfiguration.Errors) {
		alertError = error
		showAlert = true
	}

	private func fetchRequestTopHeadlines() {
		if !selectedCountry.isEmpty {
			fetchRequestTopHeadlinesUseCase
				.fetchRequest(country: selectedCountry)
		}
	}

	private func fetchRequestTopHeadlinesSources() {
		fetchRequestTopHeadlinesSourcesUseCase
			.fetchSourcesRequest()
	}

	private func readTopHeadlines() {
		readTopHeadlinesUseCase
			.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { [weak self] topHeadlines in
				self?.articles = topHeadlines.articles
				self?.updateStateTopHeadlines(completion: topHeadlines.articles?.isEmpty == false ? .finished : self?.stateTopHeadlines != .isInitialLoading ? .failure(AppConfiguration.Errors.read) : .finished,
											  failureState: .emptyRead)
			})
			.store(in: &cancellable)
	}

	private func readTopHeadlinesSources() {
		readTopHeadlinesSourcesUseCase
			.readSources()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { [weak self] sources in
				self?.sources = sources.sources
				/// Sorted set of unique country codes
				self?.countries = Array(Set(sources.sources?.compactMap { $0.country } ?? []).sorted(by: <))
				self?.updateStateSources(completion: sources.sources?.isEmpty == false ? .finished : self?.stateSources != .isInitialLoading ? .failure(AppConfiguration.Errors.read) : .finished,
										 failureState: .emptyRead)
			})
			.store(in: &cancellable)
	}

	private func updateStateSources(completion: Subscribers.Completion<Error>,
									failureState: StateSources) {
		switch completion {
		case .finished:
			stateSources = .loaded
		case .failure(let error):
			stateSources = failureState
			showAlert(error: error as? AppConfiguration.Errors ?? .error(error.localizedDescription))
		}
	}

	private func updateStateTopHeadlines(completion: Subscribers.Completion<Error>,
										 failureState: StateTopHeadlines) {
		switch completion {
		case .finished:
			stateTopHeadlines = .loaded
		case .failure(let error):
			stateTopHeadlines = failureState
			showAlert(error: error as? AppConfiguration.Errors ?? .error(error.localizedDescription))
		}
	}
}
