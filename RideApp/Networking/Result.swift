//
//  Result.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(APINetworkError)
}

public enum APINetworkError: Error {
    case jsonParsingFailure
    case invalidData
    case invalidUrl
    case requestFailed
    case invalidStatusCode(Int)
    
    public var localizedDescription: String {
        switch self {
        case .jsonParsingFailure:
            return NSLocalizedString("Unable to parse json data", comment: "Error message describing failed JSON parsing")
        case .invalidData:
            return NSLocalizedString("Failed to get data from server", comment: "Error message describing invalid data from api url")
        case .invalidUrl:
            return NSLocalizedString("The provided url is invalid", comment: "Error message describing session failed to start because of url")
        case .invalidStatusCode(let code):
            return NSLocalizedString("Status code error \(code)", comment: "Error showing the failed http status code")
        case .requestFailed:
            return NSLocalizedString("Request failed to get response", comment: "Error message descring failure to get status code 200")
        }
    }
}

extension Int {
    static let statusCode200 = 200
}
