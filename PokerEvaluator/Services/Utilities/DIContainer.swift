//
//  DIContainer.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/21/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class DIContainer {
    static func resolve() -> GameManagerProtocol {
        
        let errorHandler: ErrorHandlerProtocol = ErrorHandler()
        let console: ConsoleProtocol = ConsoleWrapper()
        let gameScorer: GameScorerProtocol = GameScorer()
        let gameJudge: GameJudgeProtocol = GameJudge()
        let gameDecoder = GameDecoder(console: console, gameScorer: gameScorer, errorHandler: errorHandler)
        
        return GameManager(console: console, gameDecoder: gameDecoder, gameJudge: gameJudge)
    }
}
