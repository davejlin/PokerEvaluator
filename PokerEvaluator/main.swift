//
//  main.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

func main() {
    let gameManager: GameManagerProtocol = DIContainer.resolve()
    gameManager.start()
}

func runUnitTests() {
    let _ = UnitTests()
}

runUnitTests()
main()
