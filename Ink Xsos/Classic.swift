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
    var turn: Int = 1
    var time: TimeInterval = 0
    var grid = [[symbolType]]()
    var winner: Int = -1

    typealias symbolType = String
    
    init() {
        for _ in 0...2 { grid.append(["-", "-", "-"]) }
    }
    
    func checkRow (_ line: Int) -> Bool {
        
        let s = grid[line][0]
        if s == "-" { return false }
        
        for item in grid[line] {
            if item != s { return false }
        }
        return true
    }
    
    func checkColumn (_ col: Int) -> Bool {
        
        let s = grid[0][col]
        if s == "-" { return false }
        
        for line in 0..<(grid.count) {
            if grid[line][col] != s { return false }
        }
        return true
    }
    
    func checkDiagonal (line: Int, inc: Int) -> Bool {
        
        var col = 0, l = line
        let s = grid[line][col]
        if s == "-" { return false }
        
        while (col < grid.count) {
            col += 1;
            l += inc
            
            if grid[l][col] != s { return false }
        }
        return true
    }

    func getWinner(symbol s: String) {

        for (i, p) in player.enumerated() {
            if p.symbol == s {
                winner = i
                return
            }
        }
        winner = -1
    }

    func isGameOver () -> Bool {
        
        let count = grid.count
        
        for line in 0..<count {
            let flag = checkRow(line)
            if flag {
                let s = grid[line][0]
                getWinner(symbol: s)
                return true
            }
        }
        for col in 0..<count {
            let flag = checkColumn(col)
            if flag {
                let s = grid[0][col]
                getWinner(symbol: s)
                return true
            }
        }
        var a = [(line: Int, inc: Int)]()
        a.append((0, -1))
        a.append((count - 1, 1))
        
        for item in a {
            let flag = checkDiagonal(line: item.line, inc: item.inc)
            if flag {
                let s = grid[item.line][0]
                getWinner(symbol: s)
                return true
            }
        }
        if turn == grid.count * grid.count - 1 {
            getWinner(symbol: "Draw")
            return true;
        }
        return false;
    }
    
    func updateGrid (number: Int, symb: String, pos: [Int]) -> Bool {
        
        if (turn & 1 == 0 && number == 2 ||
            turn & 1 == 1 && number == 1) {
                grid[pos[0]][pos[1]] = symb
                turn += 1;
                return true
        }
        return false
    }
}
