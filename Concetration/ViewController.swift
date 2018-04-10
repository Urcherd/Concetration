//
//  ViewController.swift
//  Concetration
//
//  Created by Kirill Kuzmichev on 03.04.18.
//  Copyright © 2018 Kirill Kuzmichev. All rights reserved.
//
/* Это Controller */
import UIKit

class ViewController: UIViewController {

lazy var game = Concetration(numberOfPairOfCards:  (cardsButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardsButtons: [UIButton]!
    @IBOutlet weak var scorePointLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardsButtons.index(of: sender){
             game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newGameButton(_ sender: Any) {
        game = Concetration(numberOfPairOfCards:  (cardsButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    func updateViewFromModel()  {
        for index in cardsButtons.indices
        {
        print(index)
        let button = cardsButtons[index]
        let card = game.cards[index]
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scorePointLabel.text = "Score: \(game.score)"
            
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
    
    var emojiChoiser: [String:Array<String>] =
        ["Any": ["👀", "👁", "😈", "💍", "📟", "🦄", "🐼", "💩", "☎️","⌚️","🕹","🛡","💊","🛎","🎁","📘","📕","📒"],
         "HW":["😈","💀","👹","👿","🎃","☠️","👻","👾","👀","👁","👺","😵","😱","🤡","👽","👣","👤","👥"]
        ]
    
    var emoji = [Int:String]()
    lazy var randomKey = Array<String> (emojiChoiser.keys)
    lazy var randomIndexOfTheme = Int(arc4random_uniform(UInt32(randomKey.count)))

    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoiser.count > 0 {
            var emojiTheme = emojiChoiser[randomKey[randomIndexOfTheme]]!
            let randomIndexOfEmoji = Int( arc4random_uniform(UInt32(emojiTheme.count)))
                emoji[card.identifier] = emojiTheme.remove(at: randomIndexOfEmoji)
//            print(emojiTheme)
        }
            return emoji[card.identifier] ?? "?"
    }
}
