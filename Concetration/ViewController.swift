//
//  ViewController.swift
//  Concetration
//
//  Created by Kirill Kuzmichev on 03.04.18.
//  Copyright © 2018 Kirill Kuzmichev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

lazy var game = Concetration(numberOfPairOfCards:  (cardsButtons.count + 1) / 2)
    
var flipCount = 0 {
         didSet {
                flipCountLabel.text = "Flips: \(flipCount)"
                }
}
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardsButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardsButtons.index(of: sender){
//        print("Card number is: \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
   
    func updateViewFromModel()  {
        for index in cardsButtons.indices
        {
        print(index)
        let button = cardsButtons[index]
        let card = game.cards[index]
            
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
            else if !card.isFacedUp {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.6364674832, blue: 0.1411733691, alpha: 1)
        }
            
    }
}
    func newGame() {
        flipCount = 0
        for index in cardsButtons.indices {
            
        }
    }
 var emojiChoiser = ["👀", "👁", "😈", "💍", "📟", "🦄", "🐼", "💩", "☎️"]
    
    var emoji = [Int:String]()
    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoiser.count > 0 { let randomIndex =         Int( arc4random_uniform(UInt32(emojiChoiser.count)))
                emoji[card.identifier] = emojiChoiser.remove(at: randomIndex)
        }
            return emoji[card.identifier] ?? "?"
    }
}
