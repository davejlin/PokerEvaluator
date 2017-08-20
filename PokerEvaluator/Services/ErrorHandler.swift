//
//  ErrorHandler.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol ErrorHandlerProtocol {
    static func create(with message: String)
}

class ErrorHandler: ErrorHandlerProtocol {
    static func create(with message: String) {
        print(message)
        exit(-1)
    }
}
