//
//  HandScorers.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 9/12/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol HandScorersProtocol {
    func getScorers() -> [HandScorerProtocol]
}

struct HandScorers : HandScorersProtocol {
    func getScorers() -> [HandScorerProtocol] {
        return [ // order of scorers matters ...
            StraightFlushScorer(),
            StraightFlushWithAceScorer(),
            ThreeOfAKindScorer(),
            StraightScorer(),
            StraightWithAceScorer(),
            FlushScorer(),
            PairScorer(),
            HighCardScorer()
        ]
    }
}

protocol HandScorerProtocol {
    func getScore(of sortedCards: [Card]) -> Int?
}

struct StraightFlushScorer: HandScorerProtocol {
    func getScore(of sortedCards: [Card]) -> Int? {
        let straightScorer = StraightScorer();
        let flushScorer = FlushScorer();
        
        guard straightScorer.getScore(of: sortedCards) != nil &&
            flushScorer.getScore(of: sortedCards) != nil else {
            return nil
        }
        
        return Score.STRAIGHT_FLUSH
    }
}

struct StraightFlushWithAceScorer: HandScorerProtocol {
    func getScore(of sortedCards: [Card]) -> Int? {
        let straightWithAceScorer = StraightWithAceScorer();
        let flushScorer = FlushScorer();
        
        guard straightWithAceScorer.getScore(of: sortedCards) != nil &&
            flushScorer.getScore(of: sortedCards) != nil else {
                return nil
        }
        
        return Score.STRAIGHT_FLUSH_ACE_LOW
    }
}
    
struct StraightScorer: HandScorerProtocol {
    func getScore(of sortedCards: [Card]) -> Int? {
        for i in 1..<sortedCards.count {
            if sortedCards[i-1].rank.rawValue - sortedCards[i].rank.rawValue != 1 { return nil }
        }
        return Score.STRAIGHT
    }
}

struct StraightWithAceScorer: HandScorerProtocol {
    func getScore(of sortedCards: [Card]) -> Int? {
        // Ace may have rank value 1 in a straight
        if sortedCards[0].rank == Rank._A {
            if sortedCards[1].rank == Rank._3 && sortedCards[2].rank == Rank._2 {
                return Score.STRAIGHT_ACE_LOW
            }
        }
        return nil
    }
}

struct FlushScorer: HandScorerProtocol {
    func getScore(of sortedCards: [Card]) -> Int? {
        let firstSuit = sortedCards[0].suit
        for i in 1..<sortedCards.count {
            if sortedCards[i].suit != firstSuit { return nil }
        }
        return Score.FLUSH
    }
}

struct ThreeOfAKindScorer: HandScorerProtocol {
    func getScore(of sortedCards: [Card]) -> Int? {
        let firstRank = sortedCards[0].rank
        for i in 1..<sortedCards.count {
            if sortedCards[i].rank != firstRank { return nil }
        }
        
        return Score.THREE_OF_A_KIND
    }
}

struct PairScorer: HandScorerProtocol {
    func getScore(of sortedCards: [Card]) -> Int? {
        var nMatch = 0
        for i in 0..<sortedCards.count-1 {
            for j in i+1..<sortedCards.count {
                if sortedCards[i].rank == sortedCards[j].rank { nMatch += 1 }
            }
        }
        
        if nMatch == 1 {
            return Score.PAIR
        } else {
            return nil
        }
    }
}

struct HighCardScorer: HandScorerProtocol { // should be included last as a default scorer
    func getScore(of sortedCards: [Card]) -> Int? {
        return Score.HIGH_CARD
    }
}

struct Score {
        static let STRAIGHT_FLUSH = 1000
        static let STRAIGHT_FLUSH_ACE_LOW = 999
        static let THREE_OF_A_KIND = 800
        static let STRAIGHT = 600
        static let STRAIGHT_ACE_LOW = 599
        static let FLUSH = 400
        static let PAIR = 200
        static let HIGH_CARD = 0
}
