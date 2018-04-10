//
//  Card.swift
//  Concetration
//
//  Created by Kirill Kuzmichev on 05.04.18.
//  Copyright © 2018 Kirill Kuzmichev. All rights reserved.
//

import Foundation

struct Card
{
    var isFacedUp = false
    var isMatched = false
    var isSaw = false
    var identifier: Int = 0
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int
    {
        identifierFactory += 1
        return identifierFactory
    }
    
    init ()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
