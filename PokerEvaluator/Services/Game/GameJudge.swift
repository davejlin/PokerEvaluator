//
//  GameJudge.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol GameJudgeProtocol {
    func judge(for game: [Hand]) -> [Int]
}

class GameJudge: GameJudgeProtocol {
    func judge(for game: [Hand]) -> [Int] {
        let sortedGameByScore = game.sorted(by: { $0.score > $1.score } )
        let topHands = findTopHandsByScore(for: sortedGameByScore)
        
        if topHands.count == 1 {
            return [topHands[0].id]
        }
        
        let tieScoresWinners = breakTies(for: topHands)
        
        return tieScoresWinners
            .map { $0.id }
            .sorted()
    }
    
    private func findTopHandsByScore(for sortedGame: [Hand]) -> [Hand] {
        let topScore = sortedGame[0].score
        var winners = [Hand]()
        
        winners.append(sortedGame[0])
        
        for i in 1..<sortedGame.count {
            if sortedGame[i].score == topScore {
                winners.append(sortedGame[i])
            }
        }

        return winners
    }
    
    private func breakTies(for hands: [Hand]) -> [Hand] {
        let nCards = hands[0].cards.count
        var stepSizeThroughCards = 1
        
        if hands[0].score == Score.PAIR {
            stepSizeThroughCards = 2
        }
        
        let rangeCards = stride(from:0, to: nCards, by: stepSizeThroughCards)
        var winners = [Hand]()
        
        for iCard in rangeCards {
            var topRank = hands[0].cards[iCard]
            winners = [hands[0]]
            
            for iHand in 1..<hands.count {
                let card = hands[iHand].cards[iCard]
                
                if card > topRank {
                    topRank = hands[iHand].cards[iCard]
                    winners = [hands[iHand]]
                
                } else if card == topRank {
                    winners.append(hands[iHand])
                }
            }
            
            if winners.count == 1 { return winners }
        }
        
        return winners
    }
}
