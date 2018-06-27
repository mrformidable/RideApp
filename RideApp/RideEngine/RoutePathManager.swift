//
//  RoutePathManager.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation

// Handles all events relating to the path during a user ride request
public final class RoutePathManager: NSObject {
    
    fileprivate enum JSONKeys: String {
        case overviewPolyline = "overview_polyline"
        case points = "points"
        case routes = "routes"
    }
    
    typealias RoutePathCompletionHandler = (([[String: Any]]?) -> Void)
    
    public let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    /// Line that is drawn to show the route path
    private(set) var polyLinePath: GMSPolyline?
    
    /// Draws path between two locations.
    ///
    /// - Parameter map: The map that the path will be drawn over
    /// - Parameter startCoordinate: The location where the path originates
    /// - Parameter endCoordinate: The location where the path ends
    public func drawPath(on map: GMSMapView, startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D, pathColor: UIColor = .themeIndigo(), pathLineWidth: CGFloat = 5) {
        getRoutePaths(startCoordinate, endCoordinate) { routes in
            guard let routes = routes else {
                return
            }
            DispatchQueue.main.async {
                for route in routes {
                    let routeOverviewPolyline = route[JSONKeys.overviewPolyline.rawValue] as? [String: Any]
                    guard let points = routeOverviewPolyline?[JSONKeys.points.rawValue] as? String else { return }
                    let path = GMSPath(fromEncodedPath: points)
                    self.polyLinePath = GMSPolyline(path: path)
                    self.polyLinePath?.strokeWidth = pathLineWidth
                    self.polyLinePath?.strokeColor =  pathColor
                    self.polyLinePath?.map = map
                }
            }
        }
    }
    
    public func removePath(on map: GMSMapView) {
        map.clear()
    }
    
    private func getRoutePaths(_ startCoordinate: CLLocationCoordinate2D, _ endCoordinate: CLLocationCoordinate2D, completion: @escaping RoutePathCompletionHandler)  {
        let origin = "\(startCoordinate.latitude),\(startCoordinate.longitude)"
        let destination = "\(endCoordinate.latitude),\(endCoordinate.longitude)"
        let urlPathString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        fetchJsonData(urlPath: urlPathString) { (data) in
            guard let json = data else {
                print("json data is nil")
                completion(nil)
                return
            }
            guard let routes = json[JSONKeys.routes.rawValue] as? [[String: Any]] else {
                print("failed to retreive routes")
                return
            }
            completion(routes)
        }
    }
    
    private func fetchJsonData(urlPath: String, _ completion: @escaping (JSONDictionary?) -> Void) {
        guard let url = URL(string: urlPath) else {
            return
        }
        fetchData(with: url) { (result) in
            switch result {
            case .success(let json):
                completion(json)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
                return
            }
        }
    }
}

extension RoutePathManager: ApiService {
    /// Protocol requirments, function performs nothing, use drawPath func
    public func getRideData(points: LocationPoints, completion: @escaping RideCompletionHandler) { }
}
