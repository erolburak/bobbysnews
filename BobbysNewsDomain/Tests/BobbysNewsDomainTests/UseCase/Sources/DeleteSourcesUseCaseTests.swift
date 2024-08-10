//
//  DeleteSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
import Testing

struct DeleteSourcesUseCaseTests {

	// MARK: - Private Properties

	private let sut = DeleteSourcesUseCase(sourcesRepository: SourcesRepositoryMock())

	// MARK: - Actions

	@Test("Check DeleteSourcesUseCase delete!")
	func testDelete() {
		#expect(throws: Never.self,
				"DeleteSourcesUseCase delete failed!") {
			try sut.delete()
		}
	}
}
