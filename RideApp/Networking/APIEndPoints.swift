//
//  APIEndPoints.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationEndPoint {
    var query: String { get }
    var baseUrl: String { get }
}

extension LocationEndPoint {
    var path: String {
        return "/"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: baseUrl)!
        components.path = path
        components.query = query
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

public enum LocationPoints {
    case locationCoordinates(firstCoordinates: CLLocationCoordinate2D, secondCoordinates: CLLocationCoordinate2D)
}

extension LocationPoints: LocationEndPoint {
    var baseUrl: String {
        return "https://fake-poi-api.mytaxi.com"
    }
    
    var query: String {
        switch self {
        case .locationCoordinates(let firstLocation, let secondLocation):
            return "p2Lat=\(secondLocation.latitude)&p1Lon=\(firstLocation.longitude)&p1Lat=\(firstLocation.latitude)&p2Lon=\(secondLocation.longitude)"
        }
    }
}
