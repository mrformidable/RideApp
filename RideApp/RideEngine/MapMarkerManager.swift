//
//  MapMarkerManager.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import GoogleMaps

public final class MapMarkerManager: NSObject {
    /// The marker that is placed for the start location
    private(set) var initialLocationMarker: GMSMarker?
    /// The marker that is placed for the ending location
    private(set) var endingLocationMarker: GMSMarker?
    
    /// Places marker on map for a specified location on a map for the start location
    ///
    /// Updates must be handled on main thread
    /// - Parameter map: The current map displayed
    ///   Must not be nil or func will crash
    /// - Parameter position: The location where the marker will be placed
    /// - Parameter iconImage: the image icon that will be display
    public func placeInitialLocationMarker(map: GMSMapView, position: CLLocationCoordinate2D, iconImage: UIImage = #imageLiteral(resourceName: "pickup_icon")) {
            self.initialLocationMarker = GMSMarker(position: position)
            self.initialLocationMarker?.icon = iconImage
            self.initialLocationMarker?.isDraggable = true
            self.initialLocationMarker?.map = map
    }
    
    /// Places marker on map for a specified location on a map for the end location
    ///
    /// Updates must be handled on main thread
    /// - Parameter map: The current map displayed
    ///   Must not be nil or func will crash
    /// - Parameter position: The location where the marker will be placed
    /// - Parameter iconImage: the image icon that will be display
    public func placeEndingLocationMarker(map: GMSMapView, position: CLLocationCoordinate2D, iconImage: UIImage = #imageLiteral(resourceName: "dropoff_icon")) {
            self.endingLocationMarker = GMSMarker(position: position)
            self.endingLocationMarker?.icon = iconImage
            self.endingLocationMarker?.isDraggable = true
            self.endingLocationMarker?.map = map
    }
    
    /// Moves initial marker on map to a specified location on a map for the end location
    /// - Parameter position: The location where the marker will be placed
    public func moveInitialMarker(to position: CLLocationCoordinate2D) {
        self.initialLocationMarker?.position = position
    }
    
    /// Moves ending marker on map to a specified location on a map for the end location
    /// - Parameter position: The location where the marker will be placed
    public func moveEndingLocationMarker(to position: CLLocationCoordinate2D) {
        self.endingLocationMarker?.position = position
    }
    
    /// Removes initial location marker on map
    /// - Parameter position: The location where the marker will be placed
    public func removeInitialLocationMarker() {
        initialLocationMarker?.map = nil
    }
    
    /// Removes beginning location marker on map
    /// - Parameter position: The location where the marker will be placed
    public func removeEndingLocationMarker() {
        endingLocationMarker?.map = nil
    }
    
    /// Places marker on map for a specified location on a map.
    ///
    /// This method is thread safe, all UI updates are handled already on the main thread
    /// - Parameter map: The current map displayed
    ///   Must not be nil or func will crash
    /// - Parameter position: The location where the marker will be placed
    /// - Parameter iconImage: the image icon that will be display
    public func place(map: GMSMapView, position: CLLocationCoordinate2D, iconImage: UIImage)  {
        DispatchQueue.main.async {
            let marker = GMSMarker(position: position)
            marker.icon = iconImage
            marker.isDraggable = true
            marker.map = map
        }
    }
    
    /// Places marker on map for a two different locations on a map.
    ///
    /// This method is thread safe, all UI updates are handled already on the main thread
    /// - Parameter map: The current map displayed
    ///   Must not be nil or func will crash
    /// - Parameter startLocation: The location where the marker will be placed for the first point
    /// - Parameter endLocation: The location where the marker will be placed for the second point
    /// - Parameter startLocationMarkerIcon: the image icon that will be displayed for first location
    public func placeMarkers(map: GMSMapView, startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, startLocationMarkerIcon: UIImage = #imageLiteral(resourceName: "pickup_icon"), endLocaitonMarkerIcon: UIImage = #imageLiteral(resourceName: "dropoff_icon")) {
        place(map: map, position: startLocation, iconImage: startLocationMarkerIcon)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.place(map: map, position: endLocation, iconImage: endLocaitonMarkerIcon)
        }
    }
    
}
