//
//  Result.swift
//  Packer
//
//  Created by Jaison Vieira on 09/11/17.
//  Copyright © 2017 Stone Pagamentos. All rights reserved.
//

import Foundation

public enum Result<Value> {
	case success(Value)
	case failure(Error)
}

public typealias ResultCallback<Value> = (Result<Value>) -> Void
