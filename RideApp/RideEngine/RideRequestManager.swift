//
//  RideRequestManager.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit
import CoreLocation

public protocol RideRequestProtocol {
    func requestRide(_ startLocation: CLLocation, endLocation: CLLocation, cost: Double)
}
/// Handles all ride request related events by user
public final class RideRequestManager: NSObject, RideRequestProtocol {
    
    public let locationManger: LocationManager
    
    public let markerFactory: MapMarkerManager
    
    public let fairCostManager: FairCostManager
    
    public let routePathManager: RoutePathManager
    
    public init(locationManger: LocationManager, markerFactory: MapMarkerManager = MapMarkerManager(), fairCostManager: FairCostManager = FairCostManager(), routePathManager: RoutePathManager = RoutePathManager()) {
        self.locationManger = locationManger
        self.markerFactory = markerFactory
        self.fairCostManager = fairCostManager
        self.routePathManager = routePathManager
    }
    
    /// Requests ride by the user.
    ///
    ///   The location manager's mapView property must not be nil or func will crash
    /// - Parameter startLocation: The location where the user will be picked up
    /// - Parameter endLocation: The location where the user will be dropped off
    /// - Parameter cost: The price that will be displayed to the user
    public func requestRide(_ startLocation: CLLocation, endLocation: CLLocation, cost: Double) {
        guard let map = locationManger.mapView else {
            fatalError("LocationManager's mapView property is nil. Expected mapView to be a non nil value")
        }
        markerFactory.placeMarkers(map: map, startLocation: startLocation.coordinate, endLocation: endLocation.coordinate)
    }
    
    /// Calculates ride costs.
    ///
    /// - Parameter startLocation: The location where the user will be picked up
    /// - Parameter endLocation: The location where the user will be dropped off
    /// - Parameter currency: USD or EUR
    public func calculateRideCost(_ startLocaiton: CLLocation, endLocation: CLLocation, currency: Currency = .euro) -> Double {
        return fairCostManager.calculateFair(beginningLocation: startLocaiton, endingLocation: endLocation, currency: currency)
    }
    
    /// Draws path between two locations.
    ///
    /// - Parameter map: The map that the path will be drawn over
    /// - Parameter startCoordinate: The location where the path originates
    /// - Parameter endCoordinate: The location where the path ends
    public func drawPath(on map: GMSMapView, startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D, pathColor: UIColor = .blue, pathLineWidth: CGFloat = 5) {
        routePathManager.drawPath(on: map, startCoordinate: startCoordinate, endCoordinate: endCoordinate, pathColor: pathColor, pathLineWidth: pathLineWidth)
    }
}






