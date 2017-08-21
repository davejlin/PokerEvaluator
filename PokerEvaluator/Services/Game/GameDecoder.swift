//
//  GamesDecoder.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/19/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

protocol GameDecoderProtocol {
    func decodeGameFromConsoleInput() -> [Hand]?
}

class GameDecoder: GameDecoderProtocol {
    let console: ConsoleProtocol
    let errorHandler: ErrorHandlerProtocol
    
    init(console: ConsoleProtocol, errorHandler: ErrorHandlerProtocol) {
        self.console = console
        self.errorHandler = errorHandler
    }
    
    func decodeGameFromConsoleInput() -> [Hand]? {
        guard let nString = console.readConsoleLine(), let nHands = Int(nString) else {
            errorHandler.create(with: Error.HANDS_INVALID)
            return nil
        }
        
        let game = decodeGame(with: nHands)
        
        guard nHands == game.count else {
            errorHandler.create(with: Error.HANDS_MISMATCH)
            return nil
        }
        
        return game
    }
    
    private func decodeGame(with nHands: Int) -> [Hand] {
        var hands = [Hand]()
        for _ in 0..<nHands {
            let data = console.readConsoleLine()!
                .components(separatedBy: " ")
            
            if let hand = decodeHand(from: data) {
                if hands
                    .filter({ $0.id == hand.id })
                    .count > 0 {
                    errorHandler.create(with: Error.ID_NOT_UNIQUE)
                }
                hands.append(hand)
            }
        }
        return hands
    }
    
    private func decodeHand(from data: [String]) -> Hand? {
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
