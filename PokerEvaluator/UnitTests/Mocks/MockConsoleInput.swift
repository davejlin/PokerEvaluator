//
//  MockConsoleInput.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class MockConsoleInput: ConsoleInputProtocol {
    var stringsToReturn = [String?]()
    var index = -1
    
    func readConsoleLine() -> String? {
        index += 1
        return stringsToReturn[index]
    }
}
