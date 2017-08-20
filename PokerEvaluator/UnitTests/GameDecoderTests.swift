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
        reset()
        
        let input1 = "0 Tc As 2d"
        let input2 = "1 4c Kd Js"
        
        mockConsole.stringsToReturn.append("2")
        mockConsole.stringsToReturn.append(input1)
        mockConsole.stringsToReturn.append(input2)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        guard let hand1 = game?[0] else {
            assertionFailure("failed to create hand")
            return
        }
        
        assert(hand1.id == 0, "should have id")
        assert(hand1.cards[0].rank == Rank._A, "should be sorted by rank")
        assert(hand1.cards[0].suit == Suit.s, "should have suit")
        assert(hand1.cards[1].rank == Rank._T, "should be sorted by rank")
        assert(hand1.cards[1].suit == Suit.c, "should have suit")
        assert(hand1.cards[2].rank == Rank._2, "should be sorted by rank")
        assert(hand1.cards[2].suit == Suit.d, "should have suit")
        
        guard let hand2 = game?[1] else {
            assertionFailure("failed to create hand")
            return
        }
        
        assert(hand2.id == 1, "should have id")
        assert(hand2.cards[0].rank == Rank._K, "should be sorted by rank")
        assert(hand2.cards[0].suit == Suit.d, "should have suit")
        assert(hand2.cards[1].rank == Rank._J, "should be sorted by rank")
        assert(hand2.cards[1].suit == Suit.s, "should have suit")
        assert(hand2.cards[2].rank == Rank._4, "should be sorted by rank")
        assert(hand2.cards[2].suit == Suit.c, "should have suit")
    }
    
    func testDecodeGame_InvalidID() {
        reset()
        
        let input = "a"
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        assert(game == nil, "should handle invalid id with nil")
        assert(mockErrorHander.errorMessages[0] == Error.ID, "should have error message")
    }
    
    func testDecodeGame_NoCards() {
        reset()
        
        let input = "0"
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        assert(game == nil, "should handle no cards with nil")
        assert(mockErrorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_LessThanThreeCards() {
        reset()
        
        let input = "0 Tc"
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        assert(game == nil, "should handle less than 3 cards with nil")
        assert(mockErrorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_MoreThanThreeCards() {
        reset()
        
        let input = "0 Tc As 2d 9h"
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        assert(game == nil, "should handle more than 3 cards with nil")
        assert(mockErrorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_InvalidSuit() {
        reset()
        
        let input = "0 Tc As 2e"
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        assert(game == nil, "should handle invalid suit with nil")
        assert(mockErrorHander.errorMessages[0] == Error.SUIT_INVALID, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_NoSuit() {
        reset()
        
        let input = "0 Tc As 2"
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        assert(game == nil, "should handle no suit with nil")
        assert(mockErrorHander.errorMessages[0] == Error.SUIT_INVALID, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_InvalidRank() {
        reset()
        
        let input = "0 Tc As 1c"
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        assert(game == nil, "should handle invalid rank with nil")
        assert(mockErrorHander.errorMessages[0] == Error.RANK_INVALID, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_NoRank() {
        reset()
        
        let input = "0 Tc As c"
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        assert(game == nil, "should handle no rank with nil")
        assert(mockErrorHander.errorMessages[0] == Error.RANK_INVALID, "should have error message")
        assert(mockErrorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(mockErrorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }

    func testDecodeGame_EmptyCardEntry() {
        reset()
        
        let input = "0 Tc As  "
        mockConsole.stringsToReturn.append("1")
        mockConsole.stringsToReturn.append(input)
        
        let game = gameDecoder.decodeGameFromConsoleInput()
        
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
}
