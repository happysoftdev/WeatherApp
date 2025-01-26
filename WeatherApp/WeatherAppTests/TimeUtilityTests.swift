//
//  TimeUtilityTests.swift
//  WeatherAppTests
//
//  Created by Patricia on 26.01.2025.
//

import XCTest
@testable import WeatherApp

final class TimeUtilityTests: XCTestCase {
    
    // Constant timestamps
    let constantTimestamp: TimeInterval = 1672531200  // January 1, 2023, 00:00:00 UTC
    
    
    func testConvertUnixTimestampToUTC() {
        let utcDateString = TimeUtility.convertUnixTimestampToUTC(timestamp: constantTimestamp)
        XCTAssertFalse(utcDateString.isEmpty)
        XCTAssertEqual(utcDateString, "00:00:00")
    }
    
    func testConvertUnixTimestampToLocal() {
        let localDateString = TimeUtility.convertUnixTimestampToLocal(timestamp: constantTimestamp)
        
        XCTAssertFalse(localDateString.isEmpty)
        XCTAssertEqual(localDateString, "02:00:00") // 00:00:00 UTC -> 02:00:00 local
    }
    
    func testConvertToUTC() {
        let date = Date(timeIntervalSince1970: constantTimestamp)
        let utcDateString = TimeUtility.convertToUTC(date: date)
        
        XCTAssertFalse(utcDateString.isEmpty)
        XCTAssertEqual(utcDateString, "00:00:00")
    }
    
    func testConvertToLocal() {
        let date = Date(timeIntervalSince1970: constantTimestamp)
        let localTimeString = TimeUtility.convertToLocalTime(date: date)
        
        XCTAssertFalse(localTimeString.isEmpty)
        XCTAssertEqual(localTimeString, "02:00:00")
    }
}
