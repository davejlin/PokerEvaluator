//
//  GameScorer.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol GameScorerProtocol {
    func score(of cards: [Card]) -> Int
}

class GameScorer: GameScorerProtocol {
    
    private let handScorers: [HandScorerProtocol]
    
    init () {
        handScorers = HandScorers().getScorers()
    }
    
    func score(of cards: [Card]) -> Int {
        for scorer in handScorers {
            guard let score = scorer.getScore(of: cards) else { continue }
            return score
        }
        return 0
    }
}

