//
//  GameManager.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol GameManagerProtocol {
    func start()
}

class GameManager: GameManagerProtocol {
    let errorHandler: ErrorHandlerProtocol = ErrorHandler()
    let consoleInput: ConsoleInputProtocol = ConsoleInputWrapper()
    let gameDecoder: GameDecoderProtocol
    let gameScorer: GameScorerProtocol = GameScorer()
    
    init() {
        gameDecoder = GameDecoder(consoleInput: consoleInput, errorHandler: errorHandler)
    }
    
    func start() {
        guard var game = getGame() else { return }
        gameScorer.score(of: &game)
    }
    
    func getGame() -> [Hand]? {
        
        let gameDecoder = GameDecoder(consoleInput: consoleInput, errorHandler: errorHandler)
        let game = gameDecoder.decodeGameFromConsoleInput()
        
        return game
    }
}
