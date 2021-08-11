//
//  UalaLocationManager.swift
//  Alamofire
//
//  Created by Mobile Dev on 05/05/21.
//

import Foundation
import CoreLocation

public enum UalaLocationType {
    case onlyOnce, progresive
}

public enum UalaLocationError {
    case noPermissionsGranted, noPermissionsGrantedSelected, noLocationActivated
}

public protocol UalaLocationManagerProtocol {
    var delegate: UalaLocationManagerDelegate? { get set }
    func requestAuthorization()
    func stopUpdatingLocation()
}

public protocol UalaLocationManagerDelegate {
    func handleError(_ error: UalaLocationError)
    func didUpdateLocation(coordinates: CLLocationCoordinate2D)
}

public class UalaLocationManager: NSObject {
    
    private var isInLocationRequest: Bool = false
    private var lastLocation: CLLocationCoordinate2D?
    private var locationManager: CLLocationManager
    public var locationType: UalaLocationType = .onlyOnce
    public var delegate: UalaLocationManagerDelegate?

    public override init() {
        locationManager = CLLocationManager()
    }
    
    private func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                isInLocationRequest = true
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                delegate?.handleError(.noPermissionsGranted)
            case .authorizedAlways, .authorizedWhenInUse:
                lastLocation = nil
                locationManager.delegate = self
                locationManager.startUpdatingLocation()
            @unknown default: break
            }
        } else {
            delegate?.handleError(.noLocationActivated)
        }
    }
}

extension UalaLocationManager: UalaLocationManagerProtocol {
    public func requestAuthorization() {
        startUpdatingLocation()
    }
    
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension UalaLocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if isInLocationRequest {
            if status == .denied {
                isInLocationRequest = false
                delegate?.handleError(.noPermissionsGrantedSelected)
            } else if status == .authorizedAlways || status == .authorizedWhenInUse {
                isInLocationRequest = false
                manager.startUpdatingLocation()
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        switch locationType {
        case .onlyOnce:
            if lastLocation != nil { return }
            lastLocation = coordinates
            delegate?.didUpdateLocation(coordinates: coordinates)
            manager.stopUpdatingLocation()
        case .progresive:
            lastLocation = coordinates
            delegate?.didUpdateLocation(coordinates: coordinates)
        }
    }
}
