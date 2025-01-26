//
//  ForecastViewModelTests.swift
//  WeatherAppTests
//
//  Created by Patricia on 26.01.2025.
//

import XCTest
@testable import WeatherApp

final class ForecastViewModelTests: XCTestCase {

    var viewModel: ForecastViewModel!
    var mockService: MockWeatherService!

    override func setUp() {
        super.setUp()
        mockService = MockWeatherService()
        viewModel = ForecastViewModel(weatherService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertFalse(viewModel.isLoading, "On init - isLoading should be false")
    }

    func testGetWeatherSuccess() async {
    }
}
