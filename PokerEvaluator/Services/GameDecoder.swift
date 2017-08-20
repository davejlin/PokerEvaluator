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
            print("Error: malformed or missing id")
            return nil
        }
        
        guard let cards = decodeCards(from: data) else {
            print("Error: malformed or missing cards")
            return nil
        }
        
        return Hand(id: id, cards: cards)
    }
    
    private func decodeCards(from data:[String]) -> [Card]? {
        var cards = [Card]()
        
        for i in 1..<data.count {
            let card = data[i]
            
            guard let suiteString = card.characters.last else {
                print("Error: card has no suite")
                continue
            }
            
            guard let suite = Suite(rawValue: String(suiteString)) else {
                print("Error: invalid suite")
                continue
            }
            
            let index = card.index(card.startIndex, offsetBy: card.characters.count-1)
            let valueString = card.substring(to: index)
            guard valueString.characters.count > 0 else {
                print("Error: card has no value")
                continue
            }
            
            guard let value = Value.create(from: String(valueString)) else {
                print("Error: invalid value")
                continue
            }
            
            cards.append(Card(suite: suite, value: value))
        }
        
        guard cards.count == 3 else {
            print("Error: hand has fewer than 3 cards")
            return nil
        }
        
        return cards
    }
}
