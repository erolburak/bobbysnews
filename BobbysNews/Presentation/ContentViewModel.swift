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

	enum State {
		case emptyData, emptyFetch, isLoading, loaded, noSelectedCountry
	}

	// MARK: - Use Cases

	private let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
	private let fetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase
	private let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
	private let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase
	private let saveTopHeadlinesUseCase: PSaveTopHeadlinesUseCase

	// MARK: - Properties

	var alertError: AppConfiguration.Errors?
	var articles: [Article]?
	var selectedCountry: Country = .none
	var showAlert = false
	var state: State = .isLoading

	// MARK: - Private Properties

	private var cancellable = Set<AnyCancellable>()

	// MARK: - Life Cycle

	init(deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase,
		 fetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase,
		 fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase,
		 readTopHeadlinesUseCase: PReadTopHeadlinesUseCase,
		 saveTopHeadlinesUseCase: PSaveTopHeadlinesUseCase) {
		self.deleteTopHeadlinesUseCase = deleteTopHeadlinesUseCase
		self.fetchRequestTopHeadlinesUseCase = fetchRequestTopHeadlinesUseCase
		self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
		self.readTopHeadlinesUseCase = readTopHeadlinesUseCase
		self.saveTopHeadlinesUseCase = saveTopHeadlinesUseCase
	}

	func onAppear() {
		readTopHeadlines()
		fetchRequestTopHeadlines()

		Task {
			await fetchTopHeadlines()
		}
	}

	func onDisappear() {
		cancellable.removeAll()
	}

	func delete() {
		do {
			try deleteTopHeadlinesUseCase
				.delete()
			state = .emptyData
		} catch {
			showAlert(error: .delete)
		}
	}

	func fetchTopHeadlines(state: State? = nil) async {
		if let state {
			self.state = state
		}

		if selectedCountry != .none {
			fetchTopHeadlinesUseCase
				.fetch(country: selectedCountry)
				.sink { [weak self] completion in
					self?.updateState(completion: completion)
				} receiveValue: { [weak self] topHeadlinesDto in
					if let country = self?.selectedCountry {
						self?.saveTopHeadlinesUseCase
							.save(country: country,
								  topHeadlinesDto: topHeadlinesDto)
					}
				}
				.store(in: &cancellable)
		} else {
			self.state = .noSelectedCountry
		}
	}

	func showAlert(error: AppConfiguration.Errors) {
		alertError = error
		showAlert = true
	}

	private func fetchRequestTopHeadlines() {
		fetchRequestTopHeadlinesUseCase
			.fetchRequest(country: selectedCountry)
	}

	private func readTopHeadlines() {
		readTopHeadlinesUseCase
			.read()
			.sink(receiveCompletion: { [weak self] completion in
				self?.updateState(completion: completion)
			}, receiveValue: { [weak self] topHeadlines in
				self?.articles = topHeadlines.articles
			})
			.store(in: &cancellable)
	}

	private func updateState(completion: Subscribers.Completion<Error>) {
		switch completion {
		case .finished:
			state = .loaded
		case .failure(let error):
			state = .emptyFetch
			showAlert(error: .error(error.localizedDescription))
		}
	}
}
