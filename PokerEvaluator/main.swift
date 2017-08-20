//
//  main.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

func main() {
    guard let nString = readLine(), let n = Int(nString) else {
        ErrorHandler.create(with: "Error: invalid number of hands")
        return
    }

    let gameDecoder = GameDecoder(with: n)
    let game = gameDecoder.getGame()

    guard n == game.count else {
        ErrorHandler.create(with: "Error: number of hands does not match input value")
        return
    }
}

func runUnitTests() {
    let _ = UnitTests()
}

runUnitTests()
main()
