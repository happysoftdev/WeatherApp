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
    
    func testSetLastUpdatedAtPublishedVariable() {
        let mockForecast = Forecast.mock
        
        viewModel.setLastUpdatedAt(for: mockForecast)
        
        XCTAssertFalse(viewModel.lastUpdatedAt.isEmpty)
    }
    
    func testSetSunriseSunsetDataPublishedVariables() {
        let mockForecast = Forecast.mock
        
        viewModel.setSunriseSunsetData(for: mockForecast)
        
        XCTAssertFalse(viewModel.sunrise.isEmpty)
        XCTAssertFalse(viewModel.sunset.isEmpty)
    }
    
    func testUpdateDataPublishedVariables() {
        let mockForecast = Forecast.mock
        
        viewModel.updateData(with: mockForecast)
        
        XCTAssertFalse(viewModel.locationName.isEmpty)
        XCTAssertFalse(viewModel.temperature.isEmpty)
        XCTAssertFalse(viewModel.feelsLike.isEmpty)
        XCTAssertFalse(viewModel.minTemp.isEmpty)
        XCTAssertFalse(viewModel.maxTemp.isEmpty)
        XCTAssertFalse(viewModel.condition.isEmpty)
        XCTAssertFalse(viewModel.conditionDescription.isEmpty)
        XCTAssertFalse(viewModel.humidity.isEmpty)
        XCTAssertFalse(viewModel.windSpeed.isEmpty)
        XCTAssertFalse(viewModel.sunrise.isEmpty)
        XCTAssertFalse(viewModel.sunset.isEmpty)
        XCTAssertFalse(viewModel.lastUpdatedAt.isEmpty)
    }
    
    func testUpdateDataCache() {
        let mockForecast = Forecast.mock
        
        viewModel.updateData(with: mockForecast)
        
        if let cacheArray = CacheManager.shared.getCitiesArray() {
            XCTAssertFalse(cacheArray.isEmpty)
            
            if let forecastCityCache = cacheArray.first(where: { $0.name == mockForecast.name }) {
                XCTAssertNotNil(forecastCityCache.forecast)
            } else {
                XCTFail("Forecast name not matching cache")
            }
            
        } else {
            XCTFail("No data cache")
        }
    }
    
    func testGetWeatherByCoordinates() {
        
    }
}
