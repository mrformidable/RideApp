//
//  LocationManager.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

/// Handles LocationManager related protocols
/// Assign delegate property to the class that you want to be delegated
public protocol LocationManagerDelegate: class {
    func handleUserLocationStatus(_ status: CLAuthorizationStatus)
}

public final class LocationManager: NSObject {
    /// The map that the location manager performs camera changes and updates
    public var mapView: GMSMapView?
    /// The most recent users location
    public var recentLocation: CLLocation?
    ///Handles all location related events
    private let manager = CLLocationManager()
    
    public weak var delegate: LocationManagerDelegate?
    
    convenience init(mapView: GMSMapView) {
        self.init()
        self.mapView = mapView
    }
    
    override init() {
        super.init()
        self.recentLocation = manager.location
        manager.delegate = self
    }
    
    ///  Asks user for permission to use location from device, permission must be given.
    public func requestLocationUsageAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    ///  Starts location updates
    public func startLocationUpdates() {
        manager.startUpdatingLocation()
    }
    
    ///  Stops location from updates
    public func stopLocationUpdates() {
        manager.stopUpdatingLocation()
    }
    
    ///  Sets accuracy for gps tracking
    ///
    /// - Parameter locationAccuracy: The accuracy of coordinate value (meters)
    public func setDesiredLocationAccuracy(_ locationAccuracy: CLLocationAccuracy) {
        manager.desiredAccuracy = locationAccuracy
    }
}

extension LocationManager {
    ///  Geocodes and returns address for specified location.
    ///
    /// - Parameter coordinate: The coordinate that the map will geocode
    /// - Parameter completion: Returns results from geocode process or returns an error if any.
    public func geocodeAddress(coordinate: CLLocationCoordinate2D, _ completion: @escaping GMSReverseGeocodeCallback) {
        GMSGeocoder().reverseGeocodeCoordinate(coordinate, completionHandler: completion)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        mapView?.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        manager.stopUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.handleUserLocationStatus(status)
        switch status {
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            mapView?.isMyLocationEnabled = true
        default: break
        }
    }
}
