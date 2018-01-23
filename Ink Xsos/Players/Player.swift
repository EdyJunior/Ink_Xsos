//
//  Player.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 31/10/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

struct Player<symbolType> {
    
    var symbol: symbolType
    var number: Int
    var brush : UIColor
    var isAI  : Bool
}
