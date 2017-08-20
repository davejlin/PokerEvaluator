//
//  GameJudgeTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class GameJudgeTests {
    let gameJudge: GameJudgeProtocol
    
    init() {
        gameJudge = GameJudge()
        runTests()
    }
    
    func runTests() {
        testHighCard()
    }

    func testHighCard() {
        let card11 = Card(suit: Suit.c, rank: Rank._K)
        let card12 = Card(suit: Suit.s, rank: Rank._T)
        let card13 = Card(suit: Suit.d, rank: Rank._2)
        
        let card21 = Card(suit: Suit.d, rank: Rank._Q)
        let card22 = Card(suit: Suit.h, rank: Rank._3)
        let card23 = Card(suit: Suit.s, rank: Rank._A)
        
        let card31 = Card(suit: Suit.c, rank: Rank._4)
        let card32 = Card(suit: Suit.c, rank: Rank._2)
        let card33 = Card(suit: Suit.d, rank: Rank._9)
        
        var hand1 = Hand(id: 0, cards: [card11, card12, card13].sorted())
        var hand2 = Hand(id: 1, cards: [card21, card22, card23].sorted())
        var hand3 = Hand(id: 2, cards: [card31, card32, card33].sorted())
        
        hand1.setScore(with: Score.HIGH_CARD)
        hand2.setScore(with: Score.HIGH_CARD)
        hand3.setScore(with: Score.HIGH_CARD)
        
        let winner = gameJudge.judge(for: [hand1, hand2, hand3])
        
        assert(winner[0] == 1, "should find high card winner")
    }
    
}
