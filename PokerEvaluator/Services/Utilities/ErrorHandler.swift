//
//  ErrorHandler.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol ErrorHandlerProtocol {
    func create(with message: String)
}

class ErrorHandler: ErrorHandlerProtocol {
    func create(with error: String) {
        print("Error: \(error)")
        exit(-1)
    }
}

struct Error {
    static let ID = "malformed or missing id"
    static let CARDS = "malformed or missing cards"
    static let CARDS_NUMBER =  "hand does not have 3 cards"
    static let SUIT_NONE = "card has no suit"
    static let SUIT_INVALID = "invalid suit"
    static let RANK_NONE = "card has no rank"
    static let RANK_INVALID = "invalid rank"
    static let HANDS_INVALID = "invalid number of hands"
    static let HANDS_MISMATCH = "number of hands does not match input value"
}
