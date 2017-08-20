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
    let gameScorer: GameScorerProtocol
    
    init() {
        gameJudge = GameJudge()
        gameScorer = GameScorer()
        runTests()
    }
    
    func runTests() {
        testStraightFlush()
        testStraightFlush_WithTie()
        testStraightFlush_WithTiesAndOneWinner()
        testStraightFlush_WithTiesAndThreeWinners()
        
        testHighCard()
        testHighCard_WithTieOnFirstCard()
        testHighCard_WithTieOnFirstTwoCards()
        testHighCard_WithTieOnAllThreeCards()
    }

    func testStraightFlush() {
        let card11 = Card(suit: Suit.c, rank: Rank._J)
        let card12 = Card(suit: Suit.c, rank: Rank._J)
        let card13 = Card(suit: Suit.c, rank: Rank._Q)
        
        let card21 = Card(suit: Suit.d, rank: Rank._Q)
        let card22 = Card(suit: Suit.h, rank: Rank._Q)
        let card23 = Card(suit: Suit.s, rank: Rank._Q)
        
        let card31 = Card(suit: Suit.c, rank: Rank._Q)
        let card32 = Card(suit: Suit.c, rank: Rank._J)
        let card33 = Card(suit: Suit.d, rank: Rank._K)
        
        let card41 = Card(suit: Suit.s, rank: Rank._J)
        let card42 = Card(suit: Suit.s, rank: Rank._Q)
        let card43 = Card(suit: Suit.s, rank: Rank._K)
        
        let hand1 = Hand(id: 1, cards: [card11, card12, card13].sorted())
        let hand2 = Hand(id: 2, cards: [card21, card22, card23].sorted())
        let hand3 = Hand(id: 3, cards: [card31, card32, card33].sorted())
        let hand4 = Hand(id: 4, cards: [card41, card42, card43].sorted())
        
        var hands = [hand1, hand2, hand3, hand4]
        gameScorer.score(of: &hands)
        let winner = gameJudge.judge(for: hands)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 4, "should find straight flush winner")
    }
    
    func testStraightFlush_WithTie() {
        let card11 = Card(suit: Suit.c, rank: Rank._K)
        let card12 = Card(suit: Suit.c, rank: Rank._J)
        let card13 = Card(suit: Suit.c, rank: Rank._Q)
        
        let card21 = Card(suit: Suit.d, rank: Rank._Q)
        let card22 = Card(suit: Suit.h, rank: Rank._Q)
        let card23 = Card(suit: Suit.s, rank: Rank._Q)
        
        let card31 = Card(suit: Suit.c, rank: Rank._Q)
        let card32 = Card(suit: Suit.c, rank: Rank._J)
        let card33 = Card(suit: Suit.d, rank: Rank._K)
        
        let card41 = Card(suit: Suit.s, rank: Rank._J)
        let card42 = Card(suit: Suit.s, rank: Rank._Q)
        let card43 = Card(suit: Suit.s, rank: Rank._K)
        
        let hand1 = Hand(id: 1, cards: [card11, card12, card13].sorted())
        let hand2 = Hand(id: 2, cards: [card21, card22, card23].sorted())
        let hand3 = Hand(id: 3, cards: [card31, card32, card33].sorted())
        let hand4 = Hand(id: 4, cards: [card41, card42, card43].sorted())
        
        var hands = [hand1, hand2, hand3, hand4]
        gameScorer.score(of: &hands)
        let winner = gameJudge.judge(for: hands)
        
        assert(winner.count == 2, "should find winner")
        assert(winner[0] == 1, "should find straight flush winner")
        assert(winner[1] == 4, "should find straight flush winner")
    }
    
    func testStraightFlush_WithTiesAndOneWinner() {
        let card11 = Card(suit: Suit.c, rank: Rank._K)
        let card12 = Card(suit: Suit.c, rank: Rank._J)
        let card13 = Card(suit: Suit.c, rank: Rank._Q)
        
        let card21 = Card(suit: Suit.d, rank: Rank._A)
        let card22 = Card(suit: Suit.d, rank: Rank._Q)
        let card23 = Card(suit: Suit.d, rank: Rank._K)
        
        let card31 = Card(suit: Suit.h, rank: Rank._Q)
        let card32 = Card(suit: Suit.h, rank: Rank._J)
        let card33 = Card(suit: Suit.h, rank: Rank._K)
        
        let card41 = Card(suit: Suit.s, rank: Rank._T)
        let card42 = Card(suit: Suit.s, rank: Rank._J)
        let card43 = Card(suit: Suit.s, rank: Rank._9)
        
        let hand1 = Hand(id: 1, cards: [card11, card12, card13].sorted())
        let hand2 = Hand(id: 2, cards: [card21, card22, card23].sorted())
        let hand3 = Hand(id: 3, cards: [card31, card32, card33].sorted())
        let hand4 = Hand(id: 4, cards: [card41, card42, card43].sorted())
        
        var hands = [hand1, hand2, hand3, hand4]
        gameScorer.score(of: &hands)
        let winner = gameJudge.judge(for: hands)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find straight flush winner")
    }
    
    func testStraightFlush_WithTiesAndThreeWinners() {
        let card11 = Card(suit: Suit.c, rank: Rank._K)
        let card12 = Card(suit: Suit.c, rank: Rank._J)
        let card13 = Card(suit: Suit.c, rank: Rank._Q)
        
        let card21 = Card(suit: Suit.d, rank: Rank._J)
        let card22 = Card(suit: Suit.d, rank: Rank._Q)
        let card23 = Card(suit: Suit.d, rank: Rank._K)
        
        let card31 = Card(suit: Suit.h, rank: Rank._Q)
        let card32 = Card(suit: Suit.h, rank: Rank._J)
        let card33 = Card(suit: Suit.h, rank: Rank._K)
        
        let card41 = Card(suit: Suit.s, rank: Rank._T)
        let card42 = Card(suit: Suit.s, rank: Rank._J)
        let card43 = Card(suit: Suit.s, rank: Rank._9)
        
        let hand1 = Hand(id: 1, cards: [card11, card12, card13].sorted())
        let hand2 = Hand(id: 2, cards: [card21, card22, card23].sorted())
        let hand3 = Hand(id: 3, cards: [card31, card32, card33].sorted())
        let hand4 = Hand(id: 4, cards: [card41, card42, card43].sorted())
        
        var hands = [hand1, hand2, hand3, hand4]
        gameScorer.score(of: &hands)
        let winner = gameJudge.judge(for: hands)
        
        assert(winner.count == 3, "should find winner")
        assert(winner[0] == 1, "should find straight flush winner")
        assert(winner[1] == 2, "should find straight flush winner")
        assert(winner[2] == 3, "should find straight flush winner")
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
        
        let card41 = Card(suit: Suit.s, rank: Rank._Q)
        let card42 = Card(suit: Suit.h, rank: Rank._T)
        let card43 = Card(suit: Suit.c, rank: Rank._K)
        
        let hand1 = Hand(id: 1, cards: [card11, card12, card13].sorted())
        let hand2 = Hand(id: 2, cards: [card21, card22, card23].sorted())
        let hand3 = Hand(id: 3, cards: [card31, card32, card33].sorted())
        let hand4 = Hand(id: 4, cards: [card41, card42, card43].sorted())
        
        var hands = [hand1, hand2, hand3, hand4]
        gameScorer.score(of: &hands)
        let winner = gameJudge.judge(for: hands)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find high card winner")
    }
    
    func testHighCard_WithTieOnFirstCard() {
        let card11 = Card(suit: Suit.c, rank: Rank._K)
        let card12 = Card(suit: Suit.s, rank: Rank._T)
        let card13 = Card(suit: Suit.d, rank: Rank._2)
        
        let card21 = Card(suit: Suit.d, rank: Rank._Q)
        let card22 = Card(suit: Suit.h, rank: Rank._3)
        let card23 = Card(suit: Suit.s, rank: Rank._A)
        
        let card31 = Card(suit: Suit.c, rank: Rank._4)
        let card32 = Card(suit: Suit.c, rank: Rank._2)
        let card33 = Card(suit: Suit.d, rank: Rank._9)
        
        let card41 = Card(suit: Suit.s, rank: Rank._J)
        let card42 = Card(suit: Suit.h, rank: Rank._A)
        let card43 = Card(suit: Suit.c, rank: Rank._K)
        
        let hand1 = Hand(id: 1, cards: [card11, card12, card13].sorted())
        let hand2 = Hand(id: 2, cards: [card21, card22, card23].sorted())
        let hand3 = Hand(id: 3, cards: [card31, card32, card33].sorted())
        let hand4 = Hand(id: 4, cards: [card41, card42, card43].sorted())
        
        var hands = [hand1, hand2, hand3, hand4]
        gameScorer.score(of: &hands)
        let winner = gameJudge.judge(for: hands)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 4, "should find high card winner")
    }
    
    
    func testHighCard_WithTieOnFirstTwoCards() {
        let card11 = Card(suit: Suit.c, rank: Rank._K)
        let card12 = Card(suit: Suit.s, rank: Rank._T)
        let card13 = Card(suit: Suit.d, rank: Rank._2)
        
        let card21 = Card(suit: Suit.d, rank: Rank._5)
        let card22 = Card(suit: Suit.h, rank: Rank._3)
        let card23 = Card(suit: Suit.s, rank: Rank._A)
        
        let card31 = Card(suit: Suit.c, rank: Rank._4)
        let card32 = Card(suit: Suit.c, rank: Rank._A)
        let card33 = Card(suit: Suit.d, rank: Rank._5)
        
        let card41 = Card(suit: Suit.s, rank: Rank._J)
        let card42 = Card(suit: Suit.h, rank: Rank._2)
        let card43 = Card(suit: Suit.c, rank: Rank._K)
        
        let hand1 = Hand(id: 1, cards: [card11, card12, card13].sorted())
        let hand2 = Hand(id: 2, cards: [card21, card22, card23].sorted())
        let hand3 = Hand(id: 3, cards: [card31, card32, card33].sorted())
        let hand4 = Hand(id: 4, cards: [card41, card42, card43].sorted())
        
        var hands = [hand1, hand2, hand3, hand4]
        gameScorer.score(of: &hands)
        let winner = gameJudge.judge(for: hands)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 3, "should find high card winner")
    }
    
    func testHighCard_WithTieOnAllThreeCards() {
        let card11 = Card(suit: Suit.c, rank: Rank._3)
        let card12 = Card(suit: Suit.s, rank: Rank._9)
        let card13 = Card(suit: Suit.d, rank: Rank._J)
        
        let card21 = Card(suit: Suit.d, rank: Rank._5)
        let card22 = Card(suit: Suit.h, rank: Rank._3)
        let card23 = Card(suit: Suit.s, rank: Rank._Q)
        
        let card31 = Card(suit: Suit.c, rank: Rank._K)
        let card32 = Card(suit: Suit.c, rank: Rank._2)
        let card33 = Card(suit: Suit.d, rank: Rank._T)
        
        let card41 = Card(suit: Suit.s, rank: Rank._T)
        let card42 = Card(suit: Suit.h, rank: Rank._2)
        let card43 = Card(suit: Suit.c, rank: Rank._K)
        
        let hand1 = Hand(id: 1, cards: [card11, card12, card13].sorted())
        let hand2 = Hand(id: 2, cards: [card21, card22, card23].sorted())
        let hand3 = Hand(id: 3, cards: [card31, card32, card33].sorted())
        let hand4 = Hand(id: 4, cards: [card41, card42, card43].sorted())
        
        var hands = [hand1, hand2, hand3, hand4]
        gameScorer.score(of: &hands)
        let winner = gameJudge.judge(for: hands)

        assert(winner.count == 2, "should find winner")
        assert(winner[0] == 3, "should find high card winner")
        assert(winner[1] == 4, "should find high card winner")
    }
}
