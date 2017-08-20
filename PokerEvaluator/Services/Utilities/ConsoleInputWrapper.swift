//
//  ConsoleInputWrapper.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol ConsoleInputProtocol {
    func readConsoleLine() -> String?
}

class ConsoleInputWrapper: ConsoleInputProtocol {
    func readConsoleLine() -> String? {
        return readLine()
    }
}
