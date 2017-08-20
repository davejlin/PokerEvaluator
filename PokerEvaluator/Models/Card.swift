//
//  Card.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol CardProtocol {
    var suit: Suit { get }
    var rank: Rank { get }
}

struct Card {
    let suit: Suit
    let rank: Rank
    
    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
}

enum Suit: String {
    case h, d, c, s
}

enum Rank: Int {
    case _2 = 2
    case _3 = 3
    case _4 = 4
    case _5 = 5
    case _6 = 6
    case _7 = 7
    case _8 = 8
    case _9 = 9
    case _T = 10
    case _J = 11
    case _Q = 12
    case _K = 13
    case _A = 14
    
    static func create(from string: String) -> Rank? {
        switch string {
        case "2": return ._2
        case "3": return ._3
        case "4": return ._4
        case "5": return ._5
        case "6": return ._6
        case "7": return ._7
        case "8": return ._8
        case "9": return ._9
        case "T": return ._T
        case "J": return ._J
        case "Q": return ._Q
        case "K": return ._K
        case "A": return ._A
        default: return nil
        }
    }
}
