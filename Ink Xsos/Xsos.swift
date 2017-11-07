//
//  Xsos.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 31/10/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit
import Foundation

protocol Xsos {

    associatedtype symbolType

    var player: [Player<symbolType>] { get set }
    var turn: Int { get set }
    var time: TimeInterval { get set }
    var grid: [[symbolType]] { get set }
    var winner: Int { get set }
    
    func isGameOver () -> Bool
    func updateGrid (playerNumber: Int, symb: String, pos: [Int]) -> Bool
}
