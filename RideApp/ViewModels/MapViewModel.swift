//
//  MapViewModel.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

class MapViewModel {
    
    let service: ApiService
    
    let mapMarker: MapMarkerManager
    
    let map: GMSMapView
    
    var rideCount: Int = 0
    
    init(service: ApiService, map: GMSMapView ,mapMarker: MapMarkerManager = MapMarkerManager()) {
        self.service = service
        self.mapMarker = mapMarker
        self.map = map
    }
    
    func fetchRides(bounds firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) {
        service.getRideData(points: .locationCoordinates(firstCoordinates: firstCoordinate, secondCoordinates: secondCoordinate)) { (rides, error) in
            guard let rides = rides else {
                return
            }
            self.rideCount = rides.count
            print(error?.localizedDescription ?? "")
        }
    }
}
