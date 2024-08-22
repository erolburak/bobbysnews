//
//  TopHeadlinesQueriesRepositoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class TopHeadlinesQueriesRepositoryTests: XCTestCase {
    // MARK: - Private Properties

    private var cancellable: Set<AnyCancellable>!
    private var mock: TopHeadlinesDataControllerMock!
    private var sut: TopHeadlinesQueriesRepositoryMock!

    // MARK: - Actions

    override func setUpWithError() throws {
        cancellable = Set<AnyCancellable>()
        mock = TopHeadlinesDataControllerMock()
        sut = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: mock)
    }

    override func tearDownWithError() throws {
        cancellable.removeAll()
        mock = nil
        sut = nil
    }

    func testDelete() {
        XCTAssertNoThrow(try sut.delete(country: nil))
        XCTAssertNil(mock.queriesSubject.value)
    }

    func testFetchRequest() {
        // Given
        let country = "Test 1"
        // When
        sut.fetchRequest(country: country)
        // Then
        XCTAssertEqual(mock.queriesSubject.value?.articles?.count, 1)
    }

    func testFetchRequestIsEmpty() {
        // Given
        let country = ""
        // When
        sut.fetchRequest(country: country)
        // Then
        XCTAssertEqual(mock.queriesSubject.value?.articles?.count, 0)
    }

    func testRead() async {
        // Given
        var topHeadlines: TopHeadlines?
        // When
        let expectation = expectation(description: "Read")
        sut.read()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { newTopHeadlines in
                      topHeadlines = newTopHeadlines
                      expectation.fulfill()
                  })
            .store(in: &cancellable)
        // Then
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertNotNil(topHeadlines)
    }
}
