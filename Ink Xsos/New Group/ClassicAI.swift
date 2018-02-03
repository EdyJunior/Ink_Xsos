//
//  ClassicAI.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 02/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class ClassicAI: PlayerEntity {
    
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
        
        var flag = false
        for i in 1...3 {
            for j in 1...3 {
                if grid[i][j] == "-" {
                    _ = playDelegate?.move(row: i, column: j)
                    flag = true
                }
                if flag { break }
            }
            if flag { break }
        }
    }
}
