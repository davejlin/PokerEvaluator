//
//  MockGameScorer.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/21/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class MockGameScorer: GameScorerProtocol {
    var isScoreCalled = false
    func score(of cards: [Card]) -> Int {
        isScoreCalled = true
        return 0;
    }
}
