//
//  MockConsole.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class MockConsole: ConsoleProtocol {
    var stringsToReturn = [String?]()
    var index = -1
    
    var isReadCalled = false
    func readConsoleLine() -> String? {
        isReadCalled = true
        index += 1
        return stringsToReturn[index]
    }
    
    var arrayToPrint = [Int]()
    var isPrintCalled = false
    func printOut(_ arr:[Int]) {
        isPrintCalled = true
        arrayToPrint = arr
    }
}
