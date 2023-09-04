//
//  CountryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class CountryTests: XCTestCase {

	func testCountry() {
		// Given
		let country: Country?
		// When
		country = .germany
		// Then
		XCTAssertNotNil(country)
	}
}
