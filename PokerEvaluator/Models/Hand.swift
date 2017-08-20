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
}

struct Hand: HandProtocol {
    let id: Int
    let cards: [Card]

    init(id: Int, cards: [Card]) {
        self.id = id
        self.cards = cards
    }
}
