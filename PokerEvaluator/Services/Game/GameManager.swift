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
    let console: ConsoleProtocol
    let gameDecoder: GameDecoderProtocol
    let gameScorer: GameScorerProtocol
    let gameJudge: GameJudgeProtocol
    
    init(console: ConsoleProtocol,
         gameDecoder: GameDecoderProtocol,
         gameScorer: GameScorerProtocol,
         gameJudge: GameJudgeProtocol) {
        self.console = console
        self.gameDecoder = gameDecoder
        self.gameScorer = gameScorer
        self.gameJudge = gameJudge
    }
    
    func start() {
        guard var game = getGame() else { return }
        gameScorer.score(of: &game)
        let winnerIDs = gameJudge.getSortedWinnerIds(for: game)
        console.printOut(winnerIDs)
    }
    
    private func getGame() -> [Hand]? {
        return gameDecoder.decodeGameFromConsoleInput()
    }
}
