//
//  Concetration.swift
//  Concetration
//
//  Created by Kirill Kuzmichev on 05.04.18.
//  Copyright © 2018 Kirill Kuzmichev. All rights reserved.
//
/* It is Model */

import Foundation

class Concetration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var score = 0
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else if cards[index].isSaw {
                    score -= 1
                }
                cards[index].isFacedUp = true
                cards[index].isSaw = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else if indexOfOneAndOnlyFaceUpCard != nil {
               cards[index].isFacedUp = false
                indexOfOneAndOnlyFaceUpCard = nil
                cards[index].isSaw = true
            } else  {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = index
                cards[index].isSaw = true
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
