//
//  Hand.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol HandProtocol {
    var id: Int { get }
    var cards: [Card] { get }
    var score: Int { get }
}

struct Hand: HandProtocol {
    let id: Int
    let cards: [Card]
    var score = 0

    init(id: Int, cards: [Card]) {
        self.id = id
        self.cards = cards
    }
    
    mutating func setScore(with score: Int) {
        self.score = score
    }
}
