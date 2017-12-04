//
//  APIClient.swift
//  PomboMail
//
//  Created by Jaison Vieira on 10/11/17.
//  Copyright © 2017 Stone Pagamentos. All rights reserved.
//

import UIKit

public protocol APIClient {

    var session: URLSession { get }
    var dataTask: URLSessionDataTask? { get }
    var baseUrl: String { get }
    var headers: [String:String]? { get }
    
    func send<T: APIRequest>(_ request: T, method: HTTPMethod, completion: @escaping ResultCallback<T.Response>)
    func cancel()
}

extension APIClient {
    public func cancel() {
        dataTask?.cancel()
    }
}
