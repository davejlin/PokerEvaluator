//
//  GameJudgeTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class GameJudgeTests {
    let mockConsole = MockConsole()
    let mockErrorHander = MockErrorHandler()
    
    let gameJudge: GameJudgeProtocol
    let gameScorer: GameScorerProtocol
    let gameDecoder: GameDecoderProtocol
    
    init() {
        gameJudge = GameJudge()
    
        gameScorer = GameScorer()
        gameDecoder = GameDecoder(console: mockConsole, errorHandler: mockErrorHander)
        runTests()
    }
    
    func runTests() {
        testStraightFlush()
        testStraightFlush_AceLow()
        testStraightFlush_AceHigh()
        testStraightFlush_AceLowVsHigh()
        testStraightFlush_WithTie_AceLoses()
        testStraightFlush_WithTie_AceLow()
        testStraightFlush_WithTie()
        testStraightFlush_WithTiesAndOneWinner()
        testStraightFlush_WithTiesAndThreeWinners()
        
        testThreeOfAKind()
        testThreeOfAKind_WithTie()
        testThreeOfAKind_WithTieAndTwoWinners()
        
        testStraight()
        testStraight_AceLow()
        testStraight_AceHigh()
        testStraight_AceLowVsHigh()
        testStraight_WithTie()
        testStraight_WithTie_AceLoses()
        testStraight_WithTie_AceLow()
        testStraight_WithTieAndFourWinners()
        
        testFlush()
        testFlush_WithTie()
        testFlush_WithTieAndThreeWinners()
        
        testPair()
        testPair_WithTie()
        testPair_WithTieAndTwoWinners()
        testPair_WithTieAndFourWinners()
        
        testHighCard()
        testHighCard_WithTieOnFirstCard()
        testHighCard_WithTieOnFirstTwoCards()
        testHighCard_WithTieOnAllThreeCards()
    }

    // MARK: Straight Flush
    
    func testStraightFlush() {
        let input = [
            "8",
            "1 Ac As Ad",
            "2 Kd Qd Jh",
            "3 Qc Kc Ad",
            "4 2s 3s 4s",
            "5 Ac 3d Ah",
            "6 4c 3c Ac",
            "7 Kc Kc Ac",
            "8 Kd 2c Ah"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 4, "should find straight flush winner")
    }
    
    func testStraightFlush_AceLow() {
        let input = [
            "8",
            "1 Ac As Ad",
            "2 3s 2s As",
            "3 Kd Qd Jh",
            "4 Qc Kc Ad",
            "5 Ac 3d Ah",
            "6 4c 3c Ac",
            "7 Kc Kc Ac",
            "8 Td 2c Ah"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find straight flush winner")
    }
    
    func testStraightFlush_AceHigh() {
        let input = [
            "8",
            "1 Ac As Ad",
            "2 Kd Qd Jh",
            "3 Qc Kc Ad",
            "4 Ac 3d Ah",
            "5 4c 3c Ac",
            "6 Kc Kc Ac",
            "7 Qs Ks As",
            "8 Td 2c Ah"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 7, "should find straight flush winner")
    }
    
    
    func testStraightFlush_AceLowVsHigh() {
        let input = [
            "2",
            "1 2c 3s Ad",
            "2 Kd Qd Ad",
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find straight flush winner")
    }
    
    func testStraightFlush_WithTie_AceLoses() {
        let input = [
            "2",
            "1 2c 3c 4c",
            "2 As 3s 2s"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 1, "should find straight flush winner")
    }
    
    func testStraightFlush_WithTie_AceLow() {
        let input = [
            "2",
            "1 3c Ac 2c",
            "2 As 3s 2s"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 2, "should find winner")
        assert(winner[0] == 1, "should find straight flush winner")
        assert(winner[1] == 2, "should find straight flush winner")
    }
    
    func testStraightFlush_WithTie() {
        let input = [
            "4",
            "1 Kc Jc Qc",
            "2 Qd Qh Qs",
            "3 Qc Jc Kd",
            "4 Js Qs Ks"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 2, "should find winner")
        assert(winner[0] == 1, "should find straight flush winner")
        assert(winner[1] == 4, "should find straight flush winner")
    }
    
    func testStraightFlush_WithTiesAndOneWinner() {
        let input = [
            "4",
            "1 Kc Jc Qc",
            "2 Ad Qd Kd",
            "3 Qh Jh Kh",
            "4 Ts Js 9s"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find straight flush winner")
    }
    
    func testStraightFlush_WithTiesAndThreeWinners() {
        let input = [
            "4",
            "1 Kc Jc Qc",
            "2 Jd Qd Kd",
            "3 Qh Jh Kh",
            "4 Ts Js 9s"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 3, "should find winner")
        assert(winner[0] == 1, "should find straight flush winner")
        assert(winner[1] == 2, "should find straight flush winner")
        assert(winner[2] == 3, "should find straight flush winner")
    }
    
    // MARK: Three of a Kind
    
    func testThreeOfAKind() {
        let input = [
            "4",
            "1 As Ac Kh",
            "2 2c 2d 2s",
            "3 Ac Qc Kd",
            "4 Js Ts Ks"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find three of a kind winner")
    }
    
    func testThreeOfAKind_WithTie() {
        let input = [
            "4",
            "1 As Ac Kh",
            "2 2c 2d 2s",
            "3 3s 3c 3d",
            "4 Js Ts Ks"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 3, "should find three of a kind winner")
    }
    
    func testThreeOfAKind_WithTieAndTwoWinners() {
        let input = [
            "4",
            "1 3s 3c 3h",
            "2 2c 2d 2s",
            "3 Js Ts Ks",
            "4 3s 3c 3d"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 2, "should find winner")
        assert(winner[0] == 1, "should find three of a kind winner")
        assert(winner[1] == 4, "should find three of a kind winner")
    }
    
    // MARK: Straight
    
    func testStraight() {
        let input = [
            "4",
            "1 2s 3c 4h",
            "2 Ac Ad 2s",
            "3 Td 8d Jd",
            "4 As Ts Qs"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 1, "should find straight winner")
    }
    
    func testStraight_AceHigh() {
        let input = [
            "4",
            "1 6s 3c 4h",
            "2 Ac Ad 2s",
            "3 Td 8d Jd",
            "4 Ad Kc Qs"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 4, "should find straight winner")
    }
    
    func testStraight_AceLow() {
        let input = [
            "4",
            "1 6s 3c 4h",
            "2 Ac 3d 2s",
            "3 Td 8d Jd",
            "4 As Ts Qd"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find straight winner")
    }
    
    func testStraight_AceLowVsHigh() {
        let input = [
            "4",
            "1 6s 3c 4h",
            "2 Ac 3d 2s",
            "3 Td 8d Jd",
            "4 Ks Qc Ah"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 4, "should find straight winner")
    }
    
    func testStraight_WithTie() {
        let input = [
            "4",
            "1 2s 3c 4h",
            "2 Ac Ad 2s",
            "3 3h 4d 5s",
            "4 As Ts Qs"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 3, "should find straight winner")
    }
    
    func testStraight_WithTie_AceLoses() {
        let input = [
            "2",
            "1 2s 3c Ah",
            "2 3c 4d 2s"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find straight winner")
    }
    
    func testStraight_WithTie_AceLow() {
        let input = [
            "2",
            "1 2s 3c Ah",
            "2 Ac 2d 3s"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 2, "should find winner")
        assert(winner[0] == 1, "should find straight winner")
        assert(winner[1] == 2, "should find straight winner")
    }
    
    func testStraight_WithTieAndFourWinners() {
        let input = [
            "6",
            "1 Js Qc Th",
            "2 Qc Td Js",
            "3 Qh Jd Ks",
            "4 Jd Qc Ks",
            "5 Jh Kd Qs",
            "6 Ks Js Qc"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 4, "should find winner")
        assert(winner[0] == 3, "should find straight winner")
        assert(winner[1] == 4, "should find straight winner")
        assert(winner[2] == 5, "should find straight winner")
        assert(winner[3] == 6, "should find straight winner")
    }
    
    // MARK: Flush
    
    func testFlush() {
        let input = [
            "4",
            "1 Ac Ad Ks",
            "2 Td 2d 5d",
            "3 Ah Kd Jd",
            "4 As Kc Kh"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find flush winner")
    }
    
    func testFlush_WithTie() {
        let input = [
            "4",
            "1 Ac Ad Ks",
            "2 Ks Ts Qs",
            "3 Ah Kd Kc",
            "4 3d Ad 2d"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 4, "should find flush winner")
    }
    
    func testFlush_WithTieAndThreeWinners() {
        let input = [
            "4",
            "1 3c 2c 4c",
            "2 4d 2d 3d",
            "3 Ah Ad Kc",
            "4 2s 3s 4s"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 3, "should find winner")
        assert(winner[0] == 1, "should find flush winner")
        assert(winner[1] == 2, "should find flush winner")
        assert(winner[2] == 4, "should find flush winner")
    }
    
    // MARK: Pair
    
    func testPair() {
        let input = [
            "4",
            "1 2c 3d Ks",
            "2 Ts 2s Ah",
            "3 As 2d 2c",
            "4 Ah Kc 4h"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 3, "should find pair winner")
    }
    
    func testPair_WithTie() {
        let input = [
            "4",
            "1 2c 3d Ks",
            "2 2s 2s Ah",
            "3 Ks 2d 2c",
            "4 Ah Kc 4h"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find pair winner")
    }
    
    func testPair_WithTieAndTwoWinners() {
        let input = [
            "4",
            "1 2c 3d 3s",
            "2 2s 2s Ah",
            "3 3s 2d 3c",
            "4 Ah Kc 4h"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 2, "should find winner")
        assert(winner[0] == 1, "should find pair winner")
        assert(winner[1] == 3, "should find pair winner")
    }
    
    func testPair_WithTieAndFourWinners() {
        let input = [
            "8",
            "1 4c Ad 4s",
            "2 As 5d 5c",
            "3 Ah 2c 2h",
            "4 2s 2c Ah",
            "5 5s As 5h",
            "6 3s Ad 3c",
            "7 5s 5d As",
            "8 Ac 5s 5h"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 4, "should find winner")
        assert(winner[0] == 2, "should find pair winner")
        assert(winner[1] == 5, "should find pair winner")
        assert(winner[2] == 7, "should find pair winner")
        assert(winner[3] == 8, "should find pair winner")
    }
    
    // MARK: High Card
    
    func testHighCard() {
        let input = [
            "4",
            "1 Kc Ts 2d",
            "2 Qd 3h As",
            "3 4c 2c 9d",
            "4 Qs Th Kc"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 2, "should find high card winner")
    }
    
    func testHighCard_WithTieOnFirstCard() {
        let input = [
            "4",
            "1 Kc Ts 2d",
            "2 Qd 3h As",
            "3 4c 2c 9d",
            "4 Js Ah Kc"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 4, "should find high card winner")
    }
    
    func testHighCard_WithTieOnFirstTwoCards() {
        let input = [
            "4",
            "1 Kc Ts 2d",
            "2 5d 3h As",
            "3 4c Ac 5d",
            "4 Js 2h Kc"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 1, "should find winner")
        assert(winner[0] == 3, "should find high card winner")
    }
    
    func testHighCard_WithTieOnAllThreeCards() {
        let input = [
            "4",
            "1 3c 9s Jd",
            "2 5d 3h Qs",
            "3 Kc 2c Td",
            "4 Ts 2h Kc"
        ]
        
        let winner = setupGame(with: input)
        
        assert(winner.count == 2, "should find winner")
        assert(winner[0] == 3, "should find high card winner")
        assert(winner[1] == 4, "should find high card winner")
    }
    
    // MARK: Helper methods
    
    private func setupGame(with input: [String]) -> [Int] {
        mockConsole.stringsToReturn = []
        mockConsole.index = -1
        
        for string in input {
            mockConsole.stringsToReturn.append(string)
        }
        
        var game =  gameDecoder.decodeGameFromConsoleInput()!
        gameScorer.score(of: &game)
        return gameJudge.getSortedWinnerIds(for: game)
    }
}
