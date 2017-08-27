//
//  GameJudge.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/20/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol GameJudgeProtocol {
    func getSortedWinnerIds(for game: [Hand]) -> [Int]
}

class GameJudge: GameJudgeProtocol {
    func getSortedWinnerIds(for game: [Hand]) -> [Int] {
        let sortedGameByScore = game.sorted(by: { $0.score > $1.score } )
        let winners = findTopHandsByScore(for: sortedGameByScore)
        
        if winners.count == 1 {
            return [winners[0].id]
        }
        
        let tieScoresWinners = breakTies(for: winners)
        
        return tieScoresWinners
            .map { $0.id }
            .sorted()
    }
    
    private func findTopHandsByScore(for sortedGame: [Hand]) -> [Hand] {
        let firstHand = sortedGame[0];
        let topScore = firstHand.score
        var winners = [firstHand]
        
        for i in 1..<sortedGame.count {
            if sortedGame[i].score == topScore {
                winners.append(sortedGame[i])
            }
        }

        return winners
    }
    
    private func breakTies(for hands: [Hand]) -> [Hand] {
        let type = hands[0].score
        if type == Score.PAIR {
            return breakTiesPairs(for: hands)
        }
        
        var winners = hands
        
        for iCard in 0..<hands[0].cards.count {
            winners = findWinners(in: winners, of: iCard)
            if winners.count == 1 { return winners }
        }
        
        return winners
    }
    
    private func breakTiesPairs(for hands: [Hand]) -> [Hand] {
        let pairRanks = getRanks(for: hands, with: { $0 == 2 } )
        var winners = findWinners(in: hands, with: pairRanks)
        
        if winners.count == 1 { return winners }

        let nonPairRanks = getRanks(for: winners, with: { $0 == 1 } )
        winners = findWinners(in: winners, with: nonPairRanks)
        
        return winners
    }
    
    private func findWinners(in hands:[Hand], of iCard: Int) -> [Hand] {
        let firstHand = hands[0]
        var topRank = firstHand.cards[iCard].rank
        var winners = [firstHand]
        
        for iHand in 1..<hands.count {
            let hand = hands[iHand]
            let rank = hand.cards[iCard].rank
            
            if rank > topRank {
                topRank = rank
                winners = [hand]
            } else if rank == topRank {
                winners.append(hand)
            }
        }
        
        return winners
    }
    
    private func findWinners(in hands:[Hand], with ranks: [Rank]) -> [Hand] {
        var topRank = ranks[0]
        let firstHand = hands[0]
        var winners = [firstHand]
        
        for iHand in 1..<hands.count {
            let rank = ranks[iHand]
            
            if rank > topRank {
                topRank = rank
                winners = [hands[iHand]]
            } else if rank == topRank {
                winners.append(hands[iHand])
            }
        }
        
        return winners
    }
    
    private func getRanks(for hands: [Hand], with comparitor: (Int) -> Bool) -> [Rank] {
        var pairRank = [[Rank:Int]]()
        
        hands.forEach { hand in
            var rankCount = [Rank:Int]()
            hand.cards.forEach { rankCount[$0.rank] = (rankCount[$0.rank] ?? 0) + 1 }
            pairRank.append(rankCount)
        }
        
        var ranks = [Rank]()
        pairRank.forEach { rankDict in
            for (key, value) in rankDict {
                if comparitor(value) {
                    ranks.append(key)
                }
            }
        }
        
        return ranks
    }
}
