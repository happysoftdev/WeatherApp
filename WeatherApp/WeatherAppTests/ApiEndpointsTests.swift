//
//  ApiEndpointsTests.swift
//  WeatherAppTests
//
//  Created by Patricia on 27.01.2025.
//

import XCTest
@testable import WeatherApp

//static func iconURL(code: String) -> URL? {
//    var urlString = iconBaseURL
//    urlString.append(contentsOf: "\(code).png")
//    return URL(string: urlString)
//}
//
//static func weather(with queryParameters: [URLQueryItem]) -> URL? {
//    if var components = URLComponents(string: baseURL) {
//        var parameters = queryParameters
//        parameters.append(URLQueryItem(name: "appid", value: apiKey))
//        components.queryItems = parameters
//        return components.url
//    }
//    return nil
//}

final class ApiEndpointsTests: XCTestCase {

    func testIconURL() {
        // given - the input
        let iconCode = "040d"
        
        // when
        let endpoint = ApiEndpoints.iconURL(code: iconCode)
        
        guard let endpoint = endpoint else {
            XCTFail("Endpoint is nil")
            return
        }
        XCTAssertEqual(endpoint.relativeString, "https://openweathermap.org/img/wn/040d.png")
    }
    
    func testWeatherQueryParameters() {
        // given the these query params
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "q", value: "London"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        let url = ApiEndpoints.weather(with: parameters)
        
        guard let endpoint = url else {
            XCTFail("Endpoint is nil")
            return
        }
        XCTAssertEqual(endpoint.relativeString, "https://api.openweathermap.org/data/2.5/weather?q=London&units=metric&appid=55d3b00d9ec14f573cb1ae24908a0d11")
    }
}
