//
//  main.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

guard let nString = readLine(), let n = Int(nString) else {
    print("Error: invalid number of hands")
    exit(-1)
}

let gameDecoder = GameDecoder(with: n)
let game = gameDecoder.getGame()

print(game)
