//
//  ForecastViewModelTests.swift
//  WeatherAppTests
//
//  Created by Patricia on 26.01.2025.
//

import XCTest
import Combine
@testable import WeatherApp

final class ForecastViewModelTests: XCTestCase {
    
    var viewModel: ForecastViewModel!
    var mockService: MockWeatherService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockWeatherService()
        viewModel = ForecastViewModel(weatherService: mockService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
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
    
    func testFetchWeatherByCity_Success() {
        
        // Given
        mockService.mockForecast = Forecast.mock
        
        let expectation = XCTestExpectation(description: "Fetch weather by city successfully")
        CacheManager.shared.invalidateForecastArrayCache()
        
        viewModel.locationName = "London"
        
        // When
        viewModel.fetchData(lat: nil, lon: nil, city: "London")
        
        viewModel.$locationName
            .dropFirst()
            .sink { city in
                if city == "London" {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 4)
        
        // Then
        XCTAssertEqual(viewModel.locationName, "London")
        XCTAssertEqual(viewModel.temperature, "4°C")
        XCTAssertEqual(viewModel.condition, "Clouds")
        
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchWeatherByCity_EmptyCityName() {
        viewModel.locationName = ""
        
        viewModel.fetchData(lat: nil, lon: nil, city: nil)
        
        XCTAssertEqual(viewModel.errorMessage, "Please choose a city / use your location")
    }
    
    func testFetchWeatherByCity_Error() {
        mockService.shouldReturnError = true // this controls the failure/success
        
        let expectation = XCTestExpectation(description: "Fetch weather by city fails with error")
        CacheManager.shared.invalidateForecastArrayCache()
        
        viewModel.locationName = "NonExistentCity"
        viewModel.fetchData(lat: nil, lon: nil, city: "NonExistentCity")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                if let error { // MockServiceError
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 4)
        
        // Assert
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testFetchWeatherByLocation_Success() {
        mockService.mockForecast = Forecast.mock
        
        let expectation = XCTestExpectation(description: "Fetch weather by location successfully")
        
        viewModel.fetchData(lat: Forecast.mock.coord.lat, lon: Forecast.mock.coord.lon, city: nil)
        
        // Observe changes in `cityName` using Combine
        viewModel.$locationName
            .dropFirst()
            .sink { city in
                if city == "London" {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
        
        // Assert
        XCTAssertEqual(viewModel.locationName, "London")
        XCTAssertEqual(viewModel.temperature, "4°C")
        XCTAssertEqual(viewModel.conditionDescription, "broken clouds")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchWeatherByLocation_Error() {
        mockService.shouldReturnError = true
        
        let expectation = XCTestExpectation(description: "Fetch weather by location fails with error")
        
        viewModel.fetchData(lat: Forecast.mock.coord.lat, lon: Forecast.mock.coord.lon, city: nil)
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                if error != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testFetchDataFromCache() {
        var city = City(forecast: Forecast.mock)
        CacheManager.shared.addCityCache(city)
        
        viewModel.locationName = city.name
        viewModel.fetchData(lat: nil, lon: nil, city: city.name)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.temperature, "4°C")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testUnitStringCelsius() {
        XCTAssertTrue(viewModel.unitString().contains("C"))
    }
    
    func testUnitStringFahrenheit() {
        viewModel.unit = .fahrenheit
        XCTAssertTrue(viewModel.unitString().contains("F"))
    }
}
