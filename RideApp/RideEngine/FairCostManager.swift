//
//  FairCostManager.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import CoreLocation

/// Handles all cost related events when user requests ride
@objc public final class FairCostManager: NSObject {
    
    private(set) var eurUSDExchangeRate = 1.176470588
    
    private(set) var baseEURFair: Double = 3.90
    
    private(set) var euroKmCost: Double = 2
    
    private(set) var kilometersInMiles: Double = 0.621371
    
    public var baseUSDFair: Double {
        return baseEURFair * eurUSDExchangeRate
    }
    
    public var dollarKmCost: Double {
        return euroKmCost * eurUSDExchangeRate
    }
    /// Calculates estimated cost for the user.
    ///
    /// This method uses a base fair + a fixed kilometer/hour rate * the total distance travelled in kilometers. The base euro fair cost is 3.9€ and the kilometer/ hour cost is 2€, An exchange rate of 1.176470588 is used for dollars. For example:
    ///
    ///     The cost for a trip with a distance of 3km in Euros
    ///     3.9€ + (3km * 2€) = 9.9€
    ///     In dollars, 9.9€ * 1.176470588 = 11.65$
    ///
    /// - Parameter beginningLocation: Initial distance that the user starts
    /// - Parameter endingLocation: The end distance where the user will exit
    /// - Parameter currency: The currency that the user will be charged for the transcation, either USD or EUR
    /// - Parameter cost: The price that will be displayed to the user
    public func calculateFair(beginningLocation: CLLocation, endingLocation: CLLocation, currency: Currency = .euro) -> Double {
        /// Distance returned is in meters so we divide by 1000 to get kilometers
        let distance = beginningLocation.distance(from: endingLocation) / 1000
        switch currency {
        case .euro:
            return baseEURFair + ((distance / kilometersInMiles) * euroKmCost)
        case .dollar:
            return baseUSDFair + ((distance / kilometersInMiles) * dollarKmCost)
        }
    }
    
}
