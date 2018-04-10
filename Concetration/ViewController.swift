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
    
//var flipCount = 0 {
//         didSet {
//                flipCountLabel.text = "Flips: \(flipCount)"
//                }
//}
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardsButtons: [UIButton]!
    @IBOutlet weak var scorePointLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
//        flipCount += 1
        
        if let cardNumber = cardsButtons.index(of: sender){
//        print("Card number is: \(cardNumber)")
             game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newGameButton(_ sender: Any) {
//        flipCount = 0
        game = Concetration(numberOfPairOfCards:  (cardsButtons.count + 1) / 2)
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
    lazy var rundomKey = Array<String> (emojiChoiser.keys)

    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoiser.count > 0 {
            let randomIndexOfTheme = Int(arc4random_uniform(UInt32(rundomKey.count)))
            var emojiTheme = emojiChoiser[rundomKey[randomIndexOfTheme]]
            let randomIndexOfEmoji = Int( arc4random_uniform(UInt32(emojiTheme!.count)))
                emoji[card.identifier] = emojiTheme?.remove(at: randomIndexOfEmoji)
//            print(emojiTheme)
        }
            return emoji[card.identifier] ?? "?"
    }
}
