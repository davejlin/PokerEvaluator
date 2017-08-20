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
    let errorHandler: ErrorHandlerProtocol
    let nHands: Int
    
    init(with nHands: Int, errorHandler: ErrorHandlerProtocol) {
        self.nHands = nHands
        self.errorHandler = errorHandler
    }
    
    func getGame() -> [Hand] {
        var arr = [Hand]()
        for _ in 0..<nHands {
            let data = readLine()!
                .components(separatedBy: " ")
            
            if let hand = decodeHand(from: data) {
                arr.append(hand)
            }
        }
        return arr
    }
    
    func decodeHand(from data: [String]) -> Hand? {
        guard let id = Int(data[0]) else {
            errorHandler.create(with: Error.ID)
            return nil
        }
        
        guard let cards = decodeCards(from: data) else {
            errorHandler.create(with: Error.CARDS)
            return nil
        }
        
        return Hand(id: id, cards: cards.sorted())
    }
    
    private func decodeCards(from data:[String]) -> [Card]? {
        var cards = [Card]()
        
        for i in 1..<data.count {
            let card = data[i]
            
            guard let suitString = card.characters.last else {
                errorHandler.create(with: Error.SUIT_NONE)
                break
            }
            
            guard let suit = Suit(rawValue: String(suitString)) else {
                errorHandler.create(with: Error.SUIT_INVALID)
                break
            }
            
            guard let rankString = card.characters.first else {
                errorHandler.create(with: Error.RANK_NONE)
                break
            }
            
            guard let rank = Rank.create(from: String(rankString)) else {
                errorHandler.create(with: Error.RANK_INVALID)
                break
            }
            
            cards.append(Card(suit: suit, rank: rank))
        }
        
        guard cards.count == 3 else {
            errorHandler.create(with: Error.CARDS_NUMBER)
            return nil
        }
        
        return cards
    }
}
