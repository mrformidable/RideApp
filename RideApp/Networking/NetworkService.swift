//
//  NetworkService.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation

public protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

public protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionProtocol {
    public func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request.url!, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

public typealias JSONDictionary = [String: Any]

public typealias JSONCompletionHandler = (Result<JSONDictionary?>) -> Void

public typealias RideCompletionHandler = (_ ride: [RideModel]?, _ error: APINetworkError?) -> Void

public protocol ApiService {
    var session: URLSessionProtocol { get }
    func fetchData(with url: URL, completion: @escaping JSONCompletionHandler)
    func getRideData(points: LocationPoints, completion: @escaping RideCompletionHandler)
}

extension ApiService {
    /// Asynchronous method the retreives json data from web with a url.
    /// - Parameter url: The url where data will be retrieved from
    /// - Parameter completion: returns optional json data
    public func fetchData(with url: URL, completion: @escaping JSONCompletionHandler) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { completion(.failure(.requestFailed)); return }
            if httpResponse.statusCode == .statusCode200 {
                guard let data = data else { completion(.failure(.invalidData)); return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONDictionary
                    completion(.success(json))
                } catch {
                    completion(.failure(.jsonParsingFailure))
                }
            } else {
                completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                return
            }
        }
        task.resume()
    }
}

/// Handles all api related network calls to server
final class RideApiNetworkService: NSObject, ApiService {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    /// Fetches data from api for specified location coordinates
    ///
    /// - Parameter points: The current map displayed
    /// - Parameter completion: Returns an optional array of Ride or APINetwork error if any
    func getRideData(points: LocationPoints, completion: @escaping RideCompletionHandler) {
        guard let apiUrl = points.request.url else {
            completion(nil, .invalidUrl)
            return
        }
        fetchData(with: apiUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    guard let ridesArray = json?["poiList"] as? [JSONDictionary] else {
                        completion(nil, .requestFailed)
                        return
                    }
                    ridesArray.forEach({
                        if let ride = RideModel(dict: $0) {
                            completion([ride], nil)
                        }
                    })
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}

