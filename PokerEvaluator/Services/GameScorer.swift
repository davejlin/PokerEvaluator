//
//  GameScorer.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol GameScorerProtocol {
    func score(of hands: inout [Hand])
}

class GameScorer: GameScorerProtocol {
    func score(of hands: inout [Hand]) {
        for i in 0..<hands.count {
            hands[i].setScore(with: calculateScore(of: hands[i].cards))
        }
    }
    
    private func calculateScore(of sortedCards: [Card]) -> Int {
        let straight = isStraight(of: sortedCards)
        let flush = isFlush(of: sortedCards)
        
        if straight && flush { return Score.STRAIGHT_FLUSH }
        if straight { return Score.STRAIGHT }
        if isThreeOfAKind(of: sortedCards) { return Score.THREE_OF_A_KIND }
        if flush { return Score.FLUSH }
        if isPair(of: sortedCards) { return Score.PAIR }
        
        return Score.HIGH_CARD
    }
    
    private func isStraight(of sortedCards: [Card]) -> Bool {
        for i in 1..<sortedCards.count {
            if sortedCards[i-1].rank.rawValue - sortedCards[i].rank.rawValue != 1 { return false }
        }
        
        return true
    }
    
    private func isFlush(of sortedCards: [Card]) -> Bool {
        let firstSuit = sortedCards[0].suit
        for i in 1..<sortedCards.count {
            if sortedCards[i].suit != firstSuit { return false }
        }
        
        return true
    }
    
    private func isThreeOfAKind(of sortedCards: [Card]) -> Bool {
        let firstRank = sortedCards[0].rank
        for i in 1..<sortedCards.count {
            if sortedCards[i].rank != firstRank { return false }
        }
        
        return true
    }
    
    private func isPair(of sortedCards: [Card]) -> Bool {
        for i in 0..<sortedCards.count-1 {
            for j in i+1..<sortedCards.count {
                if sortedCards[i].rank == sortedCards[j].rank { return true }
            }
        }
        
        return false
    }
}

struct Score {
    static let STRAIGHT_FLUSH = 1000
    static let THREE_OF_A_KIND = 800
    static let STRAIGHT = 600
    static let FLUSH = 400
    static let PAIR = 200
    static let HIGH_CARD = 0
}
