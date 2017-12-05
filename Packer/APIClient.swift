//
//  APIClient.swift
//  Packer
//
//  Created by Jaison Vieira on 10/11/17.
//  Copyright © 2017 Stone Pagamentos. All rights reserved.
//

import UIKit

/// For every different API consumed with this library
/// - Must conform to Encodable too, so that all stored public parameters
///   of types conforming this protocol will be encoded as parameters.
public protocol APIClient {

    /// URLSession can be initialized the way the user needs.
    var session: URLSession { get }
    /// URLSessionDataTask that will be used by the APIClient instance.
    var dataTask: URLSessionDataTask? { get }
    /// Base URL for the API
    var baseUrl: String { get }
    
    /// Send API requests.
    ///
    /// - Parameters:
    ///   - request: Class/struct that implements the APIRequest protocol.
    ///   - method: HTTPMethod to send the request.
    ///   - completion: Type alias declared as 'Response' in the request.
    func send<T: APIRequest>(_ request: T, method: HTTPMethod, completion: @escaping ResultCallback<T.Response>)
    /// Cancel the request.
    func cancel()
}

extension APIClient {
    /// Cancel the request.
    public func cancel() {
        dataTask?.cancel()
    }
}
