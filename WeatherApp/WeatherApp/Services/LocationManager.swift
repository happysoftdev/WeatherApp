//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Patricia on 25.01.2025.
//

import Foundation
import CoreLocation
   
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var locationName: String?
    @Published var errorMessage: String?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.currentLocation = newLocation.coordinate
        self.fetchLocationName(for: newLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
        
        switch manager.authorizationStatus {
        case .notDetermined:
            errorMessage = "Please allow location permissions to show your current location's weather"
        case .denied:
            errorMessage = "Location permissions denied"
        case .restricted:
            errorMessage = "Location permissions restricted"
        default:
            errorMessage = nil
        }
    }
    
    private func fetchLocationName(for location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                self?.errorMessage = "Could not get your location's name"
            } else if let placemark = placemarks?.first {
                self?.locationName = placemark.locality ?? "Unknown Location"
            }
        }
    }
}
