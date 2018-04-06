//
//  Concetration.swift
//  Concetration
//
//  Created by Kirill Kuzmichev on 05.04.18.
//  Copyright © 2018 Kirill Kuzmichev. All rights reserved.
//

import Foundation

class Concetration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init (numberOfPairOfCards: Int) {
        for _ in 0..<numberOfPairOfCards {
        let card = Card ()
        cards += [card, card]
        }
        for _ in 1..<cards.count {
            cards.append(cards.remove(at: Int(arc4random_uniform(UInt32(cards.count)))))
        }
    }
}
