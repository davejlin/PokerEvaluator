//
//  GameScorerTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class GameScorerTests {
    let gameScorer: GameScorer
    
    init() {
        gameScorer = GameScorer()
        runTests()
    }

    func runTests() {
        testCalculateScore_StraightFlush()
        testCalculateScore_Straight()
        testCalculateScore_Flush()
        testCalculateScore_ThreeOfAKind()
        testCalculateScore_ThreeOfAKind_WithFlush()
        testCalculateScore_Pair()
        testCalculateScore_Pair_WithFlush()
        testCalculateScore_HighCard()
    }
    
    func testCalculateScore_StraightFlush() {
        let cards1 = [
            Card(suit: Suit.c, rank: Rank._3),
            Card(suit: Suit.c, rank: Rank._5),
            Card(suit: Suit.c, rank: Rank._4)
            ].sorted()
        
        let cards2 = [
            Card(suit: Suit.s, rank: Rank._9),
            Card(suit: Suit.s, rank: Rank._7),
            Card(suit: Suit.s, rank: Rank._8)
            ].sorted()
        
        let cards3 = [
            Card(suit: Suit.h, rank: Rank._9),
            Card(suit: Suit.h, rank: Rank._J),
            Card(suit: Suit.h, rank: Rank._T)
            ].sorted()
        
        let cards4 = [
            Card(suit: Suit.d, rank: Rank._A),
            Card(suit: Suit.d, rank: Rank._Q),
            Card(suit: Suit.d, rank: Rank._K)
            ].sorted()
        
        let hand1 = Hand(id: 0, cards: cards1)
        let hand2 = Hand(id: 1, cards: cards2)
        let hand3 = Hand(id: 2, cards: cards3)
        let hand4 = Hand(id: 3, cards: cards4)
        
        var hands = [hand1, hand2, hand3, hand4]
        
        gameScorer.score(of: &hands)
        
        for hand in hands {
            assert(hand.score == Score.STRAIGHT_FLUSH)
        }
    }
    
    func testCalculateScore_Straight() {
        let cards1 = [
            Card(suit: Suit.c, rank: Rank._3),
            Card(suit: Suit.h, rank: Rank._5),
            Card(suit: Suit.s, rank: Rank._4)
        ].sorted()
        
        let cards2 = [
            Card(suit: Suit.s, rank: Rank._9),
            Card(suit: Suit.d, rank: Rank._7),
            Card(suit: Suit.d, rank: Rank._8)
            ].sorted()

        let cards3 = [
            Card(suit: Suit.c, rank: Rank._9),
            Card(suit: Suit.h, rank: Rank._J),
            Card(suit: Suit.s, rank: Rank._T)
            ].sorted()
        
        let cards4 = [
            Card(suit: Suit.c, rank: Rank._A),
            Card(suit: Suit.h, rank: Rank._Q),
            Card(suit: Suit.s, rank: Rank._K)
            ].sorted()
        
        let hand1 = Hand(id: 0, cards: cards1)
        let hand2 = Hand(id: 1, cards: cards2)
        let hand3 = Hand(id: 2, cards: cards3)
        let hand4 = Hand(id: 3, cards: cards4)
        
        var hands = [hand1, hand2, hand3, hand4]
        
        gameScorer.score(of: &hands)
        
        for hand in hands {
            assert(hand.score == Score.STRAIGHT)
        }
    }
    
    func testCalculateScore_Flush() {
        let cards1 = [
            Card(suit: Suit.c, rank: Rank._7),
            Card(suit: Suit.c, rank: Rank._5),
            Card(suit: Suit.c, rank: Rank._4)
            ].sorted()
        
        let cards2 = [
            Card(suit: Suit.s, rank: Rank._A),
            Card(suit: Suit.s, rank: Rank._7),
            Card(suit: Suit.s, rank: Rank._J)
            ].sorted()
        
        let cards3 = [
            Card(suit: Suit.h, rank: Rank._9),
            Card(suit: Suit.h, rank: Rank._2),
            Card(suit: Suit.h, rank: Rank._K)
            ].sorted()
        
        let cards4 = [
            Card(suit: Suit.d, rank: Rank._A),
            Card(suit: Suit.d, rank: Rank._Q),
            Card(suit: Suit.d, rank: Rank._6)
            ].sorted()
        
        let hand1 = Hand(id: 0, cards: cards1)
        let hand2 = Hand(id: 1, cards: cards2)
        let hand3 = Hand(id: 2, cards: cards3)
        let hand4 = Hand(id: 3, cards: cards4)
        
        var hands = [hand1, hand2, hand3, hand4]
        
        gameScorer.score(of: &hands)
        
        for hand in hands {
            assert(hand.score == Score.FLUSH)
        }
    }
    
    func testCalculateScore_ThreeOfAKind() {
        let cards1 = [
            Card(suit: Suit.c, rank: Rank._3),
            Card(suit: Suit.h, rank: Rank._3),
            Card(suit: Suit.s, rank: Rank._3)
            ].sorted()
        
        let cards2 = [
            Card(suit: Suit.s, rank: Rank._K),
            Card(suit: Suit.d, rank: Rank._K),
            Card(suit: Suit.d, rank: Rank._K)
            ].sorted()
        
        let cards3 = [
            Card(suit: Suit.c, rank: Rank._T),
            Card(suit: Suit.h, rank: Rank._T),
            Card(suit: Suit.s, rank: Rank._T)
            ].sorted()
        
        let cards4 = [
            Card(suit: Suit.c, rank: Rank._5),
            Card(suit: Suit.h, rank: Rank._5),
            Card(suit: Suit.s, rank: Rank._5)
            ].sorted()
        
        let hand1 = Hand(id: 0, cards: cards1)
        let hand2 = Hand(id: 1, cards: cards2)
        let hand3 = Hand(id: 2, cards: cards3)
        let hand4 = Hand(id: 3, cards: cards4)
        
        var hands = [hand1, hand2, hand3, hand4]
        
        gameScorer.score(of: &hands)
        
        for hand in hands {
            assert(hand.score == Score.THREE_OF_A_KIND)
        }
    }
    
    func testCalculateScore_ThreeOfAKind_WithFlush() {
        let cards1 = [
            Card(suit: Suit.c, rank: Rank._3),
            Card(suit: Suit.c, rank: Rank._3),
            Card(suit: Suit.c, rank: Rank._3)
            ].sorted()
        
        let cards2 = [
            Card(suit: Suit.d, rank: Rank._K),
            Card(suit: Suit.d, rank: Rank._K),
            Card(suit: Suit.d, rank: Rank._K)
            ].sorted()
        
        let cards3 = [
            Card(suit: Suit.h, rank: Rank._T),
            Card(suit: Suit.h, rank: Rank._T),
            Card(suit: Suit.h, rank: Rank._T)
            ].sorted()
        
        let cards4 = [
            Card(suit: Suit.s, rank: Rank._5),
            Card(suit: Suit.s, rank: Rank._5),
            Card(suit: Suit.s, rank: Rank._5)
            ].sorted()
        
        let hand1 = Hand(id: 0, cards: cards1)
        let hand2 = Hand(id: 1, cards: cards2)
        let hand3 = Hand(id: 2, cards: cards3)
        let hand4 = Hand(id: 3, cards: cards4)
        
        var hands = [hand1, hand2, hand3, hand4]
        
        gameScorer.score(of: &hands)
        
        for hand in hands {
            assert(hand.score == Score.THREE_OF_A_KIND)
        }
    }

    func testCalculateScore_Pair() {
        let cards1 = [
            Card(suit: Suit.c, rank: Rank._3),
            Card(suit: Suit.h, rank: Rank._Q),
            Card(suit: Suit.c, rank: Rank._3)
            ].sorted()
        
        let cards2 = [
            Card(suit: Suit.s, rank: Rank._A),
            Card(suit: Suit.d, rank: Rank._K),
            Card(suit: Suit.d, rank: Rank._K)
            ].sorted()
        
        let cards3 = [
            Card(suit: Suit.h, rank: Rank._T),
            Card(suit: Suit.h, rank: Rank._2),
            Card(suit: Suit.d, rank: Rank._T)
            ].sorted()
        
        let cards4 = [
            Card(suit: Suit.c, rank: Rank._7),
            Card(suit: Suit.h, rank: Rank._5),
            Card(suit: Suit.s, rank: Rank._5)
            ].sorted()
        
        let hand1 = Hand(id: 0, cards: cards1)
        let hand2 = Hand(id: 1, cards: cards2)
        let hand3 = Hand(id: 2, cards: cards3)
        let hand4 = Hand(id: 3, cards: cards4)
        
        var hands = [hand1, hand2, hand3, hand4]
        
        gameScorer.score(of: &hands)
        
        for hand in hands {
            assert(hand.score == Score.PAIR)
        }
    }
    
    func testCalculateScore_Pair_WithFlush() {
        let cards1 = [
            Card(suit: Suit.c, rank: Rank._3),
            Card(suit: Suit.c, rank: Rank._Q),
            Card(suit: Suit.c, rank: Rank._3)
            ].sorted()
        
        let cards2 = [
            Card(suit: Suit.s, rank: Rank._A),
            Card(suit: Suit.s, rank: Rank._K),
            Card(suit: Suit.s, rank: Rank._K)
            ].sorted()
        
        let cards3 = [
            Card(suit: Suit.h, rank: Rank._T),
            Card(suit: Suit.h, rank: Rank._2),
            Card(suit: Suit.h, rank: Rank._T)
            ].sorted()
        
        let cards4 = [
            Card(suit: Suit.d, rank: Rank._7),
            Card(suit: Suit.d, rank: Rank._5),
            Card(suit: Suit.d, rank: Rank._5)
            ].sorted()
        
        let hand1 = Hand(id: 0, cards: cards1)
        let hand2 = Hand(id: 1, cards: cards2)
        let hand3 = Hand(id: 2, cards: cards3)
        let hand4 = Hand(id: 3, cards: cards4)
        
        var hands = [hand1, hand2, hand3, hand4]
        
        gameScorer.score(of: &hands)
        
        for hand in hands {
            assert(hand.score == Score.FLUSH)
        }
    }

    func testCalculateScore_HighCard() {
        let cards1 = [
            Card(suit: Suit.c, rank: Rank._7),
            Card(suit: Suit.s, rank: Rank._5),
            Card(suit: Suit.c, rank: Rank._4)
            ].sorted()
        
        let cards2 = [
            Card(suit: Suit.s, rank: Rank._A),
            Card(suit: Suit.d, rank: Rank._7),
            Card(suit: Suit.c, rank: Rank._J)
            ].sorted()
        
        let cards3 = [
            Card(suit: Suit.h, rank: Rank._9),
            Card(suit: Suit.h, rank: Rank._2),
            Card(suit: Suit.s, rank: Rank._K)
            ].sorted()
        
        let cards4 = [
            Card(suit: Suit.d, rank: Rank._A),
            Card(suit: Suit.c, rank: Rank._Q),
            Card(suit: Suit.h, rank: Rank._6)
            ].sorted()
        
        let hand1 = Hand(id: 0, cards: cards1)
        let hand2 = Hand(id: 1, cards: cards2)
        let hand3 = Hand(id: 2, cards: cards3)
        let hand4 = Hand(id: 3, cards: cards4)
        
        var hands = [hand1, hand2, hand3, hand4]
        
        gameScorer.score(of: &hands)
        
        for hand in hands {
            assert(hand.score == Score.HIGH_CARD)
        }
    }
}
