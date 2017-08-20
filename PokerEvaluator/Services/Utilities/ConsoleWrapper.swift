//
//  ConsoleWrapper.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol ConsoleProtocol {
    func readConsoleLine() -> String?
    func printOut(_ arr: [Int])
}

class ConsoleWrapper: ConsoleProtocol {

    func readConsoleLine() -> String? {
        return readLine()
    }

    func printOut(_ arr: [Int]) {
        for i in arr {
            print(i, terminator: " ")
        }
    }
}
