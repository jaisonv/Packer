//
//  APIError.swift
//  Packer
//
//  Created by Jaison Vieira on 09/11/17.
//  Copyright © 2017 Stone Pagamentos. All rights reserved.
//

import Foundation

/// Enum containing default API errors
///
/// - encoding: Error enconding JSON.
/// - decoding: Error decoding JSON.
/// - server: Error from API.
public enum APIError: Error {
    case encoding
    case decoding
    case server(errors: [String], message: String?)
}
