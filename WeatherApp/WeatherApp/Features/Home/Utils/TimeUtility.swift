//
//  TimeUtility.swift
//  WeatherApp
//
//  Created by Patricia on 26.01.2025.
//

import Foundation

class TimeUtility {
    
    static func convertUnixTimestampToLocal(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        return convertToLocalTime(date: date)
    }
    
    static func convertUnixTimestampToUTC(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        return convertToUTC(date: date)
    }
    
    // Convert Date to UTC string
    static func convertToUTC(date: Date) -> String {
        let utcFormatter = DateFormatter()
        utcFormatter.timeStyle = .medium
        utcFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return utcFormatter.string(from: date)
    }
    
    // Convert Date to Local Time string
    static func convertToLocalTime(date: Date) -> String {
        let localFormatter = DateFormatter()
        localFormatter.timeStyle = .medium
        localFormatter.timeZone = TimeZone.current // Local time zone
        return localFormatter.string(from: date)
    }
}
