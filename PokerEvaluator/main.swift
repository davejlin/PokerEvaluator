//
//  main.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

let errorHander: ErrorHandlerProtocol = ErrorHandler()

func getGame() -> [Hand]? {
    guard let nString = readLine(), let nHands = Int(nString) else {
        errorHander.create(with: Error.HANDS_INVALID)
        return nil
    }
    
    let gameDecoder = GameDecoder(with: nHands, errorHandler: errorHander)
    let game = gameDecoder.getGame()
    
    guard nHands == game.count else {
        errorHander.create(with: Error.HANDS_MISMATCH)
        return nil
    }
    
    return game
}

func main() {
    guard var game = getGame() else { return }
    
    let gameScorer = GameScorer()
    gameScorer.score(of: &game)
    
}

func runUnitTests() {
    let _ = UnitTests()
}

runUnitTests()
main()
