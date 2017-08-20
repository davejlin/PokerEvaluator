//
//  UnitTests.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class UnitTests {
    init() {
        runTests()
    }
    
    func runTests() {
        sortTests()
        gameDecoderTests()
    }
    
    func sortTests() {
        let _ = SortTests()
    }
    
    func gameDecoderTests() {
        let _ = GameDecoderTests()
    }
    
}
