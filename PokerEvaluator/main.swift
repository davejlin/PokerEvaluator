//
//  main.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

func main() {
    let errorHander: ErrorHandlerProtocol = ErrorHandler()
    
    guard let nString = readLine(), let nHands = Int(nString) else {
        errorHander.create(with: Error.HANDS_INVALID)
        return
    }

    let gameDecoder = GameDecoder(with: nHands, errorHandler: errorHander)
    let game = gameDecoder.getGame()

    guard nHands == game.count else {
        errorHander.create(with: Error.HANDS_MISMATCH)
        return
    }
}

func runUnitTests() {
    let _ = UnitTests()
}

runUnitTests()
main()
