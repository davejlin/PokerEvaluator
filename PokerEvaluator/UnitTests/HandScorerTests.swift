//
//  HandScorerTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 9/12/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class HandScorerTests {
    
    init() {
        runTests()
    }
    
    func runTests() {
        testHandScorers()
        testStraightFlushScorer()
        testStraightFlushWithAceScorer()
        testStraightScorer()
        testStraightScorerWithAceHigh()
        testStraightWithAceScorer()
        testFlushScorer()
        testThreeOfAKindScorer()
        testPairScorer1()
        testPairScorer2()
        testPairScorer3()
        testPairScorer_ThreeOfAKindIsNotAPair()
    }
    
    func testHandScorers(){
        let handScorers = HandScorers()
        
        let scorers = handScorers.getScorers()
        
        assert(scorers[0] is StraightFlushScorer)
        assert(scorers[1] is StraightFlushWithAceScorer)
        assert(scorers[2] is ThreeOfAKindScorer)
        assert(scorers[3] is StraightScorer)
        assert(scorers[4] is StraightWithAceScorer)
        assert(scorers[5] is FlushScorer)
        assert(scorers[6] is PairScorer)
        assert(scorers[7] is HighCardScorer)
    }
    
    func testStraightFlushScorer() {
        let card1 = Card(suit: Suit.c, rank: Rank._2)
        let card2 = Card(suit: Suit.c, rank: Rank._3)
        let card3 = Card(suit: Suit.c, rank: Rank._4)
        
        let cards = [card1, card2, card3]
        let scorer = StraightFlushScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.STRAIGHT_FLUSH)
    }
    
    func testStraightFlushWithAceScorer() {
        let card1 = Card(suit: Suit.d, rank: Rank._3)
        let card2 = Card(suit: Suit.d, rank: Rank._2)
        let card3 = Card(suit: Suit.d, rank: Rank._A)
        
        let cards = [card1, card2, card3]
        let scorer = StraightFlushWithAceScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.STRAIGHT_FLUSH_ACE_LOW)
    }
    
    func testStraightScorer() {
        let card1 = Card(suit: Suit.c, rank: Rank._Q)
        let card2 = Card(suit: Suit.d, rank: Rank._K)
        let card3 = Card(suit: Suit.d, rank: Rank._J)
        
        let cards = [card1, card2, card3]
        let scorer = StraightScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.STRAIGHT)
    }
    
    func testStraightScorerWithAceHigh() {
        let card1 = Card(suit: Suit.c, rank: Rank._Q)
        let card2 = Card(suit: Suit.s, rank: Rank._K)
        let card3 = Card(suit: Suit.d, rank: Rank._A)
        
        let cards = [card1, card2, card3]
        let scorer = StraightScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.STRAIGHT)
    }
    
    func testStraightWithAceScorer() {
        let card1 = Card(suit: Suit.s, rank: Rank._2)
        let card2 = Card(suit: Suit.s, rank: Rank._A)
        let card3 = Card(suit: Suit.d, rank: Rank._3)
        
        let cards = [card1, card2, card3]
        let scorer = StraightWithAceScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.STRAIGHT_ACE_LOW)
    }
    
    func testFlushScorer() {
        let card1 = Card(suit: Suit.d, rank: Rank._2)
        let card2 = Card(suit: Suit.d, rank: Rank._K)
        let card3 = Card(suit: Suit.d, rank: Rank._T)
        
        let cards = [card1, card2, card3]
        let scorer = FlushScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.FLUSH)
    }
    
    func testThreeOfAKindScorer() {
        let card1 = Card(suit: Suit.s, rank: Rank._5)
        let card2 = Card(suit: Suit.d, rank: Rank._5)
        let card3 = Card(suit: Suit.d, rank: Rank._5)
        
        let cards = [card1, card2, card3]
        let scorer = ThreeOfAKindScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.THREE_OF_A_KIND)
    }
    
    func testPairScorer1() {
        let card1 = Card(suit: Suit.c, rank: Rank._A)
        let card2 = Card(suit: Suit.d, rank: Rank._5)
        let card3 = Card(suit: Suit.h, rank: Rank._A)
        
        let cards = [card1, card2, card3]
        let scorer = PairScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.PAIR)
    }
    
    func testPairScorer2() {
        let card1 = Card(suit: Suit.d, rank: Rank._2)
        let card2 = Card(suit: Suit.d, rank: Rank._9)
        let card3 = Card(suit: Suit.d, rank: Rank._9)
        
        let cards = [card1, card2, card3]
        let scorer = PairScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.PAIR)
    }
    
    func testPairScorer3() {
        let card1 = Card(suit: Suit.d, rank: Rank._2)
        let card2 = Card(suit: Suit.d, rank: Rank._2)
        let card3 = Card(suit: Suit.c, rank: Rank._K)
        
        let cards = [card1, card2, card3]
        let scorer = PairScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.PAIR)
    }
    
    func testPairScorer_ThreeOfAKindIsNotAPair() {
        let card1 = Card(suit: Suit.d, rank: Rank._5)
        let card2 = Card(suit: Suit.c, rank: Rank._5)
        let card3 = Card(suit: Suit.s, rank: Rank._5)
        
        let cards = [card1, card2, card3]
        let scorer = PairScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == nil)
    }
    
    func testHighHandScorer() {
        let card1 = Card(suit: Suit.d, rank: Rank._2)
        let card2 = Card(suit: Suit.d, rank: Rank._3)
        let card3 = Card(suit: Suit.d, rank: Rank._4)
        
        let cards = [card1, card2, card3]
        let scorer = HighCardScorer()
        let score = scorer.getScore(of: cards.sorted())
        
        assert(score == Score.HIGH_CARD)
    }
}
