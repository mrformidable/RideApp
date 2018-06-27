//
//  Ride.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
}

enum SerializationKeys: String {
    case id = "id"
    case coordinate = "coordinate"
    case fleetype = "fleetType"
    case heading = "heading"
}

enum RideType: Int {
    case taxi = 0
    case pool
}

public protocol Rideable {
    var id: Int { get }
    var coordinate: [String: Double] { get set }
    var heading: Double { get set }
    var fleetType: String { get set}
}

public struct Ride: Rideable {
    public var id: Int
    public var coordinate: [String: Double]
    public var heading: Double
    public var fleetType: String
}

extension Ride {
    init(jsonDict: JSONDictionary) throws {
        guard let id = jsonDict[SerializationKeys.id.rawValue] as? Int else {
            throw SerializationError.missing("id")
        }
        guard let coordinate = jsonDict[SerializationKeys.coordinate.rawValue] as? [String: Double] else {
            throw SerializationError.missing("coordinates")
        }
        guard let fleetType = jsonDict[SerializationKeys.fleetype.rawValue] as? String else {
            throw SerializationError.missing("fleetType")
        }
        guard let heading = jsonDict[SerializationKeys.heading.rawValue] as? Double else {
            throw SerializationError.missing("heading")
        }
        self.id = id
        self.coordinate = coordinate
        self.fleetType = fleetType
        self.heading = heading
    }
}

extension Ride: Hashable {
    public var hashValue: Int {
        return id.hashValue << 16
    }
    //Notes: From the API, each id has a different value. So two ride instances are equal if they have the same id
    public static func ==(lhs: Ride, rhs: Ride) -> Bool {
        return lhs.id == rhs.id
    }
}


