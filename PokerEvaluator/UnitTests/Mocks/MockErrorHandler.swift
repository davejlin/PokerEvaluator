//
//  MockErrorHandler.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class MockErrorHandler: ErrorHandlerProtocol {
    var errorMessages = [String]()
    func create(with error: String) {
        errorMessages.append(error)
    }
}
