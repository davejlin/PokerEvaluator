//
//  UnitTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class UnitTests {
    init() {
        runTests()
    }
    
    func runTests() {
        sortTests()
        gameDecoderTests()
        gameJudgeTests()
        gameScorerTests()
    }
    
    func sortTests() {
        let _ = SortTests()
    }
    
    func gameDecoderTests() {
        let _ = GameDecoderTests()
    }
    
    func gameJudgeTests() {
        let _ = GameJudgeTests()
    }
    
    func gameScorerTests() {
        let _ = GameScorerTests()
    }
}
