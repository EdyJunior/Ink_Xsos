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
        
        for _ in 0...3 { grid.append(["-", "-", "-", "-"]) }
        
        let p1 = Player(symbol: "X", number: 1, brush: .black)
        let p2 = Player(symbol: "O", number: 2, brush: .black)
        
        player.append(p1)
        player.append(p2)
    }
    
    func getSymbol(fromPlayer p: Int) -> String {
        
        let desiredPlayer = player.filter() { $0.number == p }
        return desiredPlayer[0].symbol
    }
    
    private func checkRow (_ row: Int) -> Bool {
        
        let s = grid[row][1]
        if s == "-" { return false }
        
        for item in 2...3 {
            if grid[row][item] != s { return false }
        }
        return true
    }
    
    private func checkColumn (_ col: Int) -> Bool {
        
        let s = grid[1][col]
        if s == "-" { return false }
        
        for line in 2...3 {
            if grid[line][col] != s { return false }
        }
        return true
    }
    
    private func checkDiagonal (row: Int, inc: Int) -> Bool {
        
        var col = 1, l = row
        let s = grid[row][col]
        if s == "-" { return false }
        
        while (col < 4) {
            if grid[l][col] != s { return false }
            l += inc
            col += 1;
        }
        return true
    }

    private func getWinner(symbol s: String) {

        for p in player {
            if p.symbol == s {
                winner = p.number
                return
            }
        }
        winner = 0
    }

    func isGameOver () -> Bool {
        
        for row in 1...3 {
            let flag = checkRow(row)
            if flag {
                let s = grid[row][1]
                getWinner(symbol: s)
                return true
            }
        }
        for col in 1...3 {
            let flag = checkColumn(col)
            if flag {
                let s = grid[1][col]
                getWinner(symbol: s)
                return true
            }
        }
        var a = [(row: Int, inc: Int)]()
        a.append((1, 1))
        a.append((3, -1))
        
        for item in a {
            let flag = checkDiagonal(row: item.row, inc: item.inc)
            if flag {
                let s = grid[item.row][1]
                getWinner(symbol: s)
                return true
            }
        }
        if turn == 10 {
            getWinner(symbol: "DRAW")
            return true;
        }
        return false;
    }
    
    func updateGrid (playerNumber: Int, symb: String, pos: [Int]) -> Bool {
        
        if (grid[pos[0]][pos[1]] == "-" &&
           (turn & 1 == 0 && playerNumber == 2 ||
            turn & 1 == 1 && playerNumber == 1)) {
                grid[pos[0]][pos[1]] = symb
                turn += 1;
                return true
        }
        return false
    }
}
