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
    let console: ConsoleProtocol = ConsoleWrapper()
    let gameDecoder: GameDecoderProtocol
    let gameScorer: GameScorerProtocol = GameScorer()
    let gameJudge: GameJudgeProtocol = GameJudge()
    
    init() {
        gameDecoder = GameDecoder(console: console, errorHandler: errorHandler)
    }
    
    func start() {
        guard var game = getGame() else { return }
        gameScorer.score(of: &game)
        let winnerIDs = gameJudge.judge(for: game)
        console.printOut(winnerIDs)
    }
    
    private func getGame() -> [Hand]? {
        let gameDecoder = GameDecoder(console: console, errorHandler: errorHandler)
        return gameDecoder.decodeGameFromConsoleInput()
    }
}
