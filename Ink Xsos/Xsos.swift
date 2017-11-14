//
//  Xsos.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 31/10/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit
import Foundation

enum MatchState {
    case finishedWithWinner, onGoing, draw
}

protocol Xsos {

    associatedtype symbolType

    var player: [Player<symbolType>] { get set }
    var turn: Int { get set }
    var time: TimeInterval { get set }
    var grid: [[symbolType]] { get set }
    var winner: Int { get set }
    
    func isGameOver () -> MatchState
    func updateGrid (playerNumber: Int, symb: String, pos: [Int]) -> Bool
}
