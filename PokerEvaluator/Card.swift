//
//  Card.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol CardProtocol {
    var suite: Suite { get }
    var value: Value { get }
}

struct Card {
    let suite: Suite
    let value: Value
    
    init(suite: Suite, value: Value) {
        self.suite = suite
        self.value = value
    }
}

enum Suite: String {
    case h, d, c, s
}

enum Value: Int {
    case _2 = 2
    case _3 = 3
    case _4 = 4
    case _5 = 5
    case _6 = 6
    case _7 = 7
    case _8 = 8
    case _9 = 9
    case _10 = 10
    case _J = 11
    case _Q = 12
    case _K = 13
    case _A = 14
    
    static func create(from string: String) -> Value? {
        switch string {
        case "2":  return ._2
        case "3":  return ._3
        case "4":  return ._4
        case "5":  return ._5
        case "6":  return ._6
        case "7":  return ._7
        case "8":  return ._8
        case "9":  return ._9
        case "10": return ._10
        case "J":  return ._J
        case "Q":  return ._Q
        case "K":  return ._K
        case "A":  return ._A
        default: return nil
        }
    }
}
