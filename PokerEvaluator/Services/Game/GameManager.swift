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
    let gameJudge: GameJudgeProtocol
    
    init(console: ConsoleProtocol,
         gameDecoder: GameDecoderProtocol,
         gameJudge: GameJudgeProtocol) {
        self.console = console
        self.gameDecoder = gameDecoder
        self.gameJudge = gameJudge
    }
    
    func start() {
        guard let game = getGame() else { return }
        let winnerIDs = gameJudge.getSortedWinnerIds(for: game)
        console.printOut(winnerIDs)
    }
    
    private func getGame() -> [Hand]? {
        return gameDecoder.decodeGameFromConsoleInput()
    }
}
