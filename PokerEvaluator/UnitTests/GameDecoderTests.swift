//
//  GameDecoderTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class GameDecoderTests {
    let errorHander = MockErrorHandler()
    let gameDecoder: GameDecoder
    
    init() {
        gameDecoder = GameDecoder(with: 0, errorHandler: errorHander)
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
        
        let expectedId = "0"
        
        let input = [expectedId, "Tc", "As", "2d"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result?.id == Int(expectedId)!, "should have id")
        assert(result?.cards[0].rank == Rank._A, "should be sorted by rank")
        assert(result?.cards[0].suit == Suit.s, "should have suit")
        assert(result?.cards[1].rank == Rank._T, "should be sorted by rank")
        assert(result?.cards[1].suit == Suit.c, "should have suit")
        assert(result?.cards[2].rank == Rank._2, "should be sorted by rank")
        assert(result?.cards[2].suit == Suit.d, "should have suit")
    }
    
    func testDecodeGame_InvalidID() {
        reset()
        
        let input = ["a"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle invalid id with nil")
        assert(errorHander.errorMessages[0] == Error.ID, "should have error message")
    }
    
    func testDecodeGame_NoCards() {
        reset()
        
        let input = ["0"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle no cards with nil")
        assert(errorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(errorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_LessThanThreeCards() {
        reset()
        
        let input = ["0", "Tc"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle less than 3 cards with nil")
        assert(errorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(errorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_MoreThanThreeCards() {
        reset()
        
        let input = ["0", "Tc", "As", "2d", "9h"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle more than 3 cards with nil")
        assert(errorHander.errorMessages[0] == Error.CARDS_NUMBER, "should have error message")
        assert(errorHander.errorMessages[1] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_InvalidSuit() {
        reset()
        
        let input = ["0", "Tc", "As", "2e"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle invalid suit with nil")
        assert(errorHander.errorMessages[0] == Error.SUIT_INVALID, "should have error message")
        assert(errorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(errorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_NoSuit() {
        reset()
        
        let input = ["0", "Tc", "As", "2"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle no suit with nil")
        assert(errorHander.errorMessages[0] == Error.SUIT_INVALID, "should have error message")
        assert(errorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(errorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_InvalidRank() {
        reset()
        
        let input = ["0", "Tc", "As", "1c"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle invalid rank with nil")
        assert(errorHander.errorMessages[0] == Error.RANK_INVALID, "should have error message")
        assert(errorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(errorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func testDecodeGame_NoRank() {
        reset()
        
        let input = ["0", "Tc", "As", "c"]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle no rank with nil")
        assert(errorHander.errorMessages[0] == Error.RANK_INVALID, "should have error message")
        assert(errorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(errorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }

    func testDecodeGame_EmptyCardEntry() {
        reset()
        
        let input = ["0", "Tc", "As", ""]
        let result = gameDecoder.decodeHand(from: input)
        
        assert(result == nil, "should handle empty card data with nil")
        assert(errorHander.errorMessages[0] == Error.SUIT_NONE, "should have error message")
        assert(errorHander.errorMessages[1] == Error.CARDS_NUMBER, "should have error message")
        assert(errorHander.errorMessages[2] == Error.CARDS, "should have error message")
    }
    
    func reset() {
        errorHander.errorMessages = []
    }
}
