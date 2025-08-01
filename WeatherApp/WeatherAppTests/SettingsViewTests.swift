//
//  SettingsViewTests.swift
//  WeatherAppTests
//
//  Created by Patricia on 29.01.2025.
//

import XCTest
@testable import WeatherApp
final class SettingsViewTests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testButtonTapChangesText() {
        let picker = app.buttons["temperatureUnitPicker"]
        
        let celsius = picker.buttons["Celsius"]
        let fahrenheit = picker.buttons["Fahrenheit"]
        
        // initially - celsius is selected
        XCTAssertTrue(celsius.isSelected)
        XCTAssertFalse(fahrenheit.isSelected)
        
        // Select Fahrenheit
        fahrenheit.tap()
        
        XCTAssertTrue(fahrenheit.isSelected)
        XCTAssertFalse(celsius.isSelected)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testPickerSelectionChangesState() {
        let view = SettingsView(viewModel: SettingsViewModel())
        let mirror = Mirror(reflecting: view)
        let selectionState = mirror.descendant("_selection") as? String
        
        XCTAssertEqual(selectionState, "Celsius")  // Check initial state
    }
}
