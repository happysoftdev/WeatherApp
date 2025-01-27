//
//  TemperatureUnitUtilityTests.swift
//  WeatherAppTests
//
//  Created by Patricia on 26.01.2025.
//

import XCTest
@testable import WeatherApp

final class TemperatureUnitUtilityTests: XCTestCase {
    
    func testMeasureUnitMetric() {
        let unit = TemperatureUnit.celsius
        let stringUnit = TemperatureUnitUtility.measureUnit(from: unit)
        
        XCTAssertFalse(stringUnit.isEmpty)
        XCTAssertEqual(stringUnit, "metric")
    }
    
    func testMeasureUnitImperial() {
        let unit = TemperatureUnit.fahrenheit
        let stringUnit = TemperatureUnitUtility.measureUnit(from: unit)
        
        XCTAssertFalse(stringUnit.isEmpty)
        XCTAssertEqual(stringUnit, "imperial")
    }
    
    func testIdFahrenheit() {
        let unit = TemperatureUnit.fahrenheit
        XCTAssertEqual(unit.id, "Fahrenheit")
    }
    
    func testIdCelsius() {
        let unit = TemperatureUnit.celsius
        XCTAssertEqual(unit.id, "Celsius")
    }
}
