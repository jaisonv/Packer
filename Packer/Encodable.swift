//
//  Encodable.swift
//  Packer
//
//  Created by Jaison Vieira on 09/11/17.
//  Copyright © 2017 Stone Pagamentos. All rights reserved.
//

import UIKit

extension Encodable {
    /// Builds a query string.
    ///
    /// - Returns: Query string to be used on a GET request
    func queryStringValue() throws -> String {
        let parametersData = try JSONEncoder().encode(self)
        
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        
        return parameters.map({ "\($0)=\($1)" })
                         .joined(separator: "&")
                         .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    /// Bulds Data object.
    ///
    /// - Returns: Returns a Data instance to be used on a request.
    func dataValue() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
