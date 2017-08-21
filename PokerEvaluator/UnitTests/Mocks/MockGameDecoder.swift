//
//  MockGameDecoder.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/21/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class MockGameDecoder: GameDecoderProtocol {
    var returnGame: [Hand]?
    var isDecodeGameFromConsoleInputCalled = false
    func decodeGameFromConsoleInput() -> [Hand]? {
        isDecodeGameFromConsoleInputCalled = true
        return returnGame
    }
}
