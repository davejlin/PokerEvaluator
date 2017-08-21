//
//  GameDecoderTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class GameDecoderTests {
    let mockConsole = MockConsole()
    let mockErrorHander = MockErrorHandler()
    let gameDecoder: GameDecoderProtocol
    
    init() {
        gameDecoder = GameDecoder(console: mockConsole, errorHandler: mockErrorHander)
        runTests()
    }
    
    func runTests() {
        testDecodeGame_SunnyDay()
        testDecodeGame_InvalidNumberOfHands()
        testDecodeGame_InvalidID()
        testDecodeGame_NoCards()
        testDecodeGame_LessThanThreeCards()
        testDecodeGame_MoreThanThreeCards()
        testDecodeGame_InvalidSuit()
        testDecodeGame_NoSuit()
        testDecodeGame_InvalidRank()
        testDecodeGame_NoRank()
        testDecodeGame_EmptyCardEntry()
    }
    
    func testDecodeGame_SunnyDay() {
        let input = [
            "2",
            "0 Tc As 2d",
            "1 4c Kd Js"
        ]
    
        guard let game = setupGame(with: input) else {
            assertionFailure("should have created game")
            return
        }
        
        assert(game.count == 2, "should have created hands")
        
        let hand1 = game[0]
        let hand2 = game[1]
        
        assert(hand1.id == 0, "should have id")
        assert(hand1.cards[0].rank == Rank._A, "should be sorted by rank")
        assert(hand1.cards[0].suit == Suit.s, "should have suit")
        assert(hand1.cards[1].rank == Rank._T, "should be sorted by rank")
        assert(hand1.cards[1].suit == Suit.c, "should have suit")
        assert(hand1.cards[2].rank == Rank._2, "should be sorted by rank")
        assert(hand1.cards[2].suit == Suit.d, "should have suit")
        
        assert(hand2.id == 1, "should have id")
        assert(hand2.cards[0].rank == Rank._K, "should be sorted by rank")
        assert(hand2.cards[0].suit == Suit.d, "should have suit")
        assert(hand2.cards[1].rank == Rank._J, "should be sorted by rank")
        assert(hand2.cards[1].suit == Suit.s, "should have suit")
        assert(hand2.cards[2].rank == Rank._4, "should be sorted by rank")
        assert(hand2.cards[2].suit == Suit.c, "should have suit")
    }
    
    func testDecodeGame_InvalidNumberOfHands() {
        let input = [
            "a"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle invalid id with nil")
        assert(mockErrorHander.errorMessages[0] == Error.HANDS_INVALID, "should have error message")
    }
    
    func testDecodeGame_InvalidID() {
        let input = [
            "1",
            "a"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle invalid id with nil")
        assert(mockErrorHander.errorMessages[0] == Error.ID, "should have error message")
    }

    func testDecodeGame_NotUniqueID() {
        let input = [
            "1",
            "1 Tc 8d 2s",
            "1 2h 3h 4h"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle not unique id with nil")
        assert(mockErrorHander.errorMessages[0] == Error.ID_NOT_UNIQUE, "should have error message")
    }
    
    func testDecodeGame_NoCards() {
        let input = [
            "1",
            "0"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle no cards with nil")
        assert(mockErrorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_LessThanThreeCards() {
        let input = [
            "1",
            "0 Tc"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle less than 3 cards with nil")
        assert(mockErrorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_MoreThanThreeCards() {
        let input = [
            "1",
            "0 Tc As 2d 9h"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle more than 3 cards with nil")
        assert(mockErrorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_InvalidSuit() {
        let input = [
            "1",
            "0 Tc As 2e"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle invalid suit with nil")
        assert(mockErrorHander.errorMessages[0] == Error.SUIT_INVALID, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_NoSuit() {
        let input = [
            "1",
            "0 Tc As 2"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle no suit with nil")
        assert(mockErrorHander.errorMessages[0] == Error.SUIT_INVALID, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_InvalidRank() {
        let input = [
            "1",
            "0 Tc As 1c"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle invalid rank with nil")
        assert(mockErrorHander.errorMessages[0] == Error.RANK_INVALID, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_NoRank() {
        let input = [
            "1",
            "0 Tc As c"
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle no rank with nil")
        assert(mockErrorHander.errorMessages[0] == Error.RANK_INVALID, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }

    func testDecodeGame_EmptyCardEntry() {
        let input = [
            "1",
            "0 Tc As  "
        ]
        
        let game = setupGame(with: input)
        
        assert(game == nil, "should handle empty card data with nil")
        assert(mockErrorHander.errorMessages[0] == Error.SUIT_NONE, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func reset() {
        mockConsole.stringsToReturn = []
        mockConsole.index = -1
        mockErrorHander.errorMessages = []
    }
    
    private func setupGame(with input: [String]) -> [Hand]? {
        reset()
        
        for string in input {
            mockConsole.stringsToReturn.append(string)
        }
        
        return gameDecoder.decodeGameFromConsoleInput()
    }
}
