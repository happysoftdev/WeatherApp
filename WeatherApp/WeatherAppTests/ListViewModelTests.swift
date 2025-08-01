//
//  ListViewModelTests.swift
//  WeatherAppTests
//
//  Created by Patricia on 26.01.2025.
//

import XCTest
@testable import WeatherApp

final class ListViewModelTests: XCTestCase {
    var viewModel: ListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ListViewModel()
    }

    func textGetWeatherIconNameBarcelona() {
        // given - city name
        let city = City(name: "Barcelona")
        
        // when - trying to get the icon name
        let icon = viewModel.getWeatherIconName(for: city)
        
        XCTAssertEqual(icon, "cloud.fill")
    }
    
    func textGetWeatherIconNameLondon() {
        // given - city name
        let city = City(name: "London")
        
        // when - trying to get the icon name
        let icon = viewModel.getWeatherIconName(for: city)
        
        XCTAssertEqual(icon, "cloud.sun.fill")
    }
    
    func textGetWeatherIconNameDefault() {
        // given - city name
        let city = City(name: "Rome")
        
        // when - trying to get the icon name
        let icon = viewModel.getWeatherIconName(for: city)
        
        XCTAssertEqual(icon, "sun.max.fill")
    }
    
}
