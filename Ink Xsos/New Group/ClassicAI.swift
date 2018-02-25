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
    var firstTurn = true
    
    init(symbol: String, number: Int, brush: UIColor = .black, delegate: PlayDelegate? = nil) {
        
        self.number = number
        self.symbol = symbol
        self.brush = brush
        self.playDelegate = delegate
    }
    
    func play(grid: [[String]]) { randomMoveIn(grid) }
    
    func randomMoveIn(_ grid: [[String]]) {
        
        var array = [(f: Int, s: Int)]()
        for i in 0...2 {
            for j in 0...2 {
                if grid[i][j] == "-" { array.append((i, j)) }
            }
        }
        let rdm = Int(arc4random_uniform(UInt32(array.count)))
        _ = playDelegate?.move(row: array[rdm].f, column: array[rdm].s)
    }
}
