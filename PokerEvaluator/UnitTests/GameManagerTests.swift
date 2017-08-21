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
        testStart_NilGame()
    }
    
    func testStart() {
        reset()
        mockGameDecoder.returnGame = []
        
        gameManager.start()
        
        assert(mockGameDecoder.isDecodeGameFromConsoleInputCalled == true, "should call gameDecoder")
        assert(mockGameScorer.isScoreCalled == true, "should call gameScorer")
        assert(mockGameJudge.isGetSortedWinnerIdsCalled == true, "should call gameJudge")
        assert(mockConsole.isPrintCalled == true, "should call console print")
    }
    
    func testStart_NilGame() {
        reset()
        mockGameDecoder.returnGame = nil
        
        gameManager.start()
        
        assert(mockGameDecoder.isDecodeGameFromConsoleInputCalled == true, "should call gameDecoder")
        assert(mockGameScorer.isScoreCalled == false, "should not call gameScorer")
        assert(mockGameJudge.isGetSortedWinnerIdsCalled == false, "should not call gameJudge")
        assert(mockConsole.isPrintCalled == false, "should not call console print")
    }
    
    func reset() {
        mockGameDecoder.isDecodeGameFromConsoleInputCalled = false
        mockGameScorer.isScoreCalled = false
        mockGameJudge.isGetSortedWinnerIdsCalled = false
        mockConsole.isPrintCalled = false
    }
}
