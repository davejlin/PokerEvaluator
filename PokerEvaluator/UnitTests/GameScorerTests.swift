//
//  GameScorerTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class GameScorerTests {
    let mockConsole = MockConsole()
    let mockErrorHander = MockErrorHandler()
    let gameDecoder: GameDecoderProtocol
    let gameScorer: GameScorerProtocol = GameScorer()
    
    init() {
        gameDecoder = GameDecoder(console: mockConsole, errorHandler: mockErrorHander)
        runTests()
    }

    func runTests() {
        testCalculateScore_StraightFlush()
        testCalculateScore_StraightFlush_AceHigh()
        testCalculateScore_StraightFlush_AceLow()
        testCalculateScore_Straight()
        testCalculateScore_Straight_AceHigh()
        testCalculateScore_Straight_AceLow()
        testCalculateScore_Flush()
        testCalculateScore_ThreeOfAKind()
        testCalculateScore_ThreeOfAKind_WithFlush()
        testCalculateScore_Pair()
        testCalculateScore_Pair_WithFlush()
        testCalculateScore_HighCard()
    }
    
    func testCalculateScore_StraightFlush() {
        let input = [
            "4",
            "0 3c 5c 4c",
            "1 9s 7s 8s",
            "2 9h Jh Th",
            "3 Ad Qd Kd"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.STRAIGHT_FLUSH)
        }
    }
    
    func testCalculateScore_StraightFlush_AceHigh() {
        let input = [
            "4",
            "0 Ac Kc Qc",
            "1 Qs As Ks",
            "2 Kh Qh Ah",
            "3 Kd Ad Qd"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.STRAIGHT_FLUSH)
        }
    }
    
    func testCalculateScore_StraightFlush_AceLow() {
        let input = [
            "4",
            "0 2c Ac 3c",
            "1 As 2s 3s",
            "2 3h 2h Ah",
            "3 3d Ad 2d"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.STRAIGHT_FLUSH_ACE_LOW)
        }
    }
    
    func testCalculateScore_Straight() {
        let input = [
            "4",
            "0 3c 5h 4s",
            "1 9s 7d 8d",
            "2 9c Jh Ts",
            "3 Ac Qh Ks"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.STRAIGHT)
        }
    }
    
    func testCalculateScore_Straight_AceHigh() {
        let input = [
            "4",
            "0 Ac Kh Qs",
            "1 Qs Ad Kd",
            "2 Qc Kh As",
            "3 Kc Ah Qs"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.STRAIGHT)
        }
    }
    
    func testCalculateScore_Straight_AceLow() {
        let input = [
            "4",
            "0 Ac 3h 2s",
            "1 2s Ad 3d",
            "2 Ac 2h 3s",
            "3 3c 2h As"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.STRAIGHT_ACE_LOW)
        }
    }
    
    func testCalculateScore_Flush() {
        let input = [
            "4",
            "0 7c 5c 4c",
            "1 As 7s 3s",
            "2 9h 2h Kh",
            "3 Ad Qd 6d"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.FLUSH)
        }
    }
    
    func testCalculateScore_ThreeOfAKind() {
        let input = [
            "4",
            "0 3c 3h 3s",
            "1 Ks Kd Kc",
            "2 Tc Th Ts",
            "3 5c 5s 5c"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.THREE_OF_A_KIND)
        }
    }
    
    func testCalculateScore_ThreeOfAKind_WithFlush() {
        let input = [
            "4",
            "0 3c 3c 3c",
            "1 Kd Kd Kd",
            "2 Th Th Th",
            "3 5s 5s 5s"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.THREE_OF_A_KIND)
        }
    }

    func testCalculateScore_Pair() {
        let input = [
            "4",
            "0 3c Qh 3d",
            "1 As Kd Kc",
            "2 Th 2h Ts",
            "3 7c 5h 5s"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.PAIR)
        }
    }
    
    func testCalculateScore_Pair_WithFlush() {
        let input = [
            "4",
            "0 3c Qc 3c",
            "1 As Ks Ks",
            "2 Th 2h Th",
            "3 7d 5d 5d"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.FLUSH)
        }
    }

    func testCalculateScore_HighCard() {
        let input = [
            "4",
            "0 7c 5s 4c",
            "1 As 7d Jc",
            "2 9h 2h Ks",
            "3 Ad Qc 6h"
        ]
        
        var game = setupGame(with: input)
        gameScorer.score(of: &game)
        
        for hand in game {
            assert(hand.score == Score.HIGH_CARD)
        }
    }
    
    private func setupGame(with input: [String]) -> [Hand] {
        mockConsole.stringsToReturn = []
        mockConsole.index = -1
        
        for string in input {
            mockConsole.stringsToReturn.append(string)
        }
        
        return gameDecoder.decodeGameFromConsoleInput()!
    }
}
