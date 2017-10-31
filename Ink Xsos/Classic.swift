//
//  Classic.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 31/10/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import Foundation

class Classic: Xsos {

    var player = [Player<symbolType>]()
    var turn: Int = 0
    var time: TimeInterval = 0
    var grid = [[symbolType]]()
    var winner: Int = -1

    typealias symbolType = String

    func isGameOver () -> Bool {
        return false;
    }
    
    func updateGrid () {
        
    }
}
