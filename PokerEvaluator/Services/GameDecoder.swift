//
//  GamesDecoder.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol GameDecoderProtocol {
    func getGame() -> [Hand]
}

class GameDecoder: GameDecoderProtocol {
    let nHands: Int;
    
    init(with nHands: Int) {
        self.nHands = nHands
    }
    
    func getGame() -> [Hand] {
        var arr = [Hand]()
        for _ in 0..<nHands {
            let data = readLine()!
                .components(separatedBy: " ")
            
            if let hand = decodeGame(from: data) {
                arr.append(hand)
            }
        }
        return arr
    }
    
    private func decodeGame(from data: [String]) -> Hand? {
        guard let id = Int(data[0]) else {
            ErrorHandler.create(with: "Error: malformed or missing id")
            return nil
        }
        
        guard let cards = decodeCards(from: data) else {
            ErrorHandler.create(with: "Error: malformed or missing cards")
            return nil
        }
        
        return Hand(id: id, cards: cards)
    }
    
    private func decodeCards(from data:[String]) -> [Card]? {
        var cards = [Card]()
        
        for i in 1..<data.count {
            let card = data[i]
            
            guard let suiteString = card.characters.last else {
                ErrorHandler.create(with: "Error: card has no suit")
                break
            }
            
            guard let suit = Suit(rawValue: String(suiteString)) else {
                ErrorHandler.create(with: "Error: invalid suit")
                break
            }
            
            guard let rankString = card.characters.first else {
                ErrorHandler.create(with: "Error: card has no rank")
                break
            }
            
            guard let rank = Rank.create(from: String(rankString)) else {
                ErrorHandler.create(with: "Error: invalid rank")
                break
            }
            
            cards.append(Card(suit: suit, rank: rank))
        }
        
        guard cards.count == 3 else {
            ErrorHandler.create(with: "Error: hand does not have 3 cards")
            return nil
        }
        
        return cards
    }
}
