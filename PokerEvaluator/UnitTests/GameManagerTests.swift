//
//  GameManagerTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/21/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class GameManagerTests {
    let mockErrorHandler = MockErrorHandler()
    let mockConsole = MockConsole()
    let mockGameScorer = MockGameScorer()
    let mockGameJudge = MockGameJudge()
    let mockGameDecoder = MockGameDecoder()
    
    let gameManager: GameManagerProtocol
    
    init() {
        gameManager = GameManager(console: mockConsole, gameDecoder: mockGameDecoder, gameScorer: mockGameScorer, gameJudge: mockGameJudge)
        
        runTests()
    }
    
    func runTests() {
        testStart()
    }
    
    func testStart() {
        mockGameDecoder.returnGame = []
        
        gameManager.start()
        
        assert(mockGameDecoder.isDecodeGameFromConsoleInputCalled == true, "should call gameDecoder")
        assert(mockGameScorer.isScoreCalled == true, "should call gameScorer")
        assert(mockGameJudge.isGetSortedWinnerIdsCalled == true, "should call gameJudge")
        assert(mockConsole.isPrintCalled == true, "should call console print")
    }
}
