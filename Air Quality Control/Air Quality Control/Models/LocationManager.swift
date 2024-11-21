//
//  LocationManager.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/8/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var locationUpdated = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation () {
        if #available(iOS 14.0, *) {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.requestLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        DispatchQueue.main.async {
            self.location = newLocation
            self.locationUpdated = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.locationStatus = status
            switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    self.locationManager.requestLocation()
                case .denied:
                    print("Location permission denied. Please enable it in Settings.")
                case .restricted:
                    print("Location permission restricted. You may not have access to location services.")
                case .notDetermined:
                    print("Location permission not determined. Requesting authorization.")
                @unknown default:
                    print("Unknown authorization status.")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location manager failed with error: \(error.localizedDescription)")
    }
    
}
