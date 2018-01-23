//
//  ClassicPlayer.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 09/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class ClassicPlayer: PlayerEntity {
    
    var symbol: String
    var number: Int
    var brush : UIColor
    var playDelegate: PlayDelegate?
    
    init(symbol: String, number: Int, brush: UIColor = .black, delegate: PlayDelegate? = nil) {
        
        self.number = number
        self.symbol = symbol
        self.brush = brush
        self.playDelegate = delegate
    }
    
    func play(grid: [[String]]) {
        
        print("Player")
    }
}
