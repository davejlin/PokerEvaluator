//
//  SortTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class SortTests {
    init() {
        runTests()
    }
    
    func runTests() {
        testCardsCorrectlySortedInDescendingOrder()
    }
    
    func testCardsCorrectlySortedInDescendingOrder() {
        let card1 = Card(suit: .c, rank: ._2)
        let card2 = Card(suit: .d, rank: ._K)
        let card3 = Card(suit: .h, rank: ._6)
        let card4 = Card(suit: .s, rank: ._8)
        let card5 = Card(suit: .c, rank: ._A)
        let card6 = Card(suit: .d, rank: ._J)
        let card7 = Card(suit: .h, rank: ._5)
        let card8 = Card(suit: .s, rank: ._Q)
        let card9 = Card(suit: .c, rank: ._9)
        let card10 = Card(suit: .d, rank: ._7)
        let card11 = Card(suit: .s, rank: ._4)
        let card12 = Card(suit: .c, rank: ._3)
        let card13 = Card(suit: .s, rank: ._T)
        let card14 = Card(suit: .s, rank: ._5)
        let card15 = Card(suit: .s, rank: ._Q)
        let card16 = Card(suit: .s, rank: ._6)
        let card17 = Card(suit: .s, rank: ._5)
        let card18 = Card(suit: .s, rank: ._A)
        let card19 = Card(suit: .s, rank: ._J)
        let card20 = Card(suit: .s, rank: ._9)
        
        var hand = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13, card14, card15, card16, card17, card18, card19, card20]
        
        hand = hand.sorted()
        
        assert(hand[0].rank == ._A, "should be sorted")
        assert(hand[1].rank == ._A, "should be sorted")
        assert(hand[2].rank == ._K, "should be sorted")
        assert(hand[3].rank == ._Q, "should be sorted")
        assert(hand[4].rank == ._Q, "should be sorted")
        assert(hand[5].rank == ._J, "should be sorted")
        assert(hand[6].rank == ._J, "should be sorted")
        assert(hand[7].rank == ._T, "should be sorted")
        assert(hand[8].rank == ._9, "should be sorted")
        assert(hand[9].rank == ._9, "should be sorted")
        assert(hand[10].rank == ._8, "should be sorted")
        assert(hand[11].rank == ._7, "should be sorted")
        assert(hand[12].rank == ._6, "should be sorted")
        assert(hand[13].rank == ._6, "should be sorted")
        assert(hand[14].rank == ._5, "should be sorted")
        assert(hand[15].rank == ._5, "should be sorted")
        assert(hand[16].rank == ._5, "should be sorted")
        assert(hand[17].rank == ._4, "should be sorted")
        assert(hand[18].rank == ._3, "should be sorted")
        assert(hand[19].rank == ._2, "should be sorted")
    }
}
