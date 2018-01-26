//
//  ClassicGame.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 25/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import Foundation

class ClassicGame {
    
    var players: [PlayerEntity]?
    var turn: Int {
        didSet {
            if winner == -1 {
                let cp = self.turn % 2 == 0 ? 1 : 0
                self.players?[cp].play(grid: self.grid)
            }
        }
    }
    var time: TimeInterval = 0
    var grid = [[String]]()
    var winner: Int = -1
    var victoryLine: VictoryLine?
    
    typealias symbolType = String
    
    init() {
        
        for _ in 0...2 { grid.append(["-", "-", "-"]) }
        self.turn = 1
    }
    
    func getSymbol(fromPlayer p: Int) -> String {
        
        let desiredPlayer = players?.filter() { $0.number == p }
        return desiredPlayer![0].symbol
    }
    
    private func checkRow (_ row: Int) -> Bool {
        
        let s = grid[row][0]
        if s == "-" { return false }
        
        for col in [1, 2] {
            if grid[row][col] != s { return false }
        }
        return true
    }
    
    private func checkColumn (_ col: Int) -> Bool {
        
        let s = grid[0][col]
        if s == "-" { return false }
        
        for row in [1, 2] {
            if grid[row][col] != s { return false }
        }
        return true
    }
    
    private func checkDiagonal (row: Int, inc: Int) -> Bool {
        
        var col = 0, r = row
        let s = grid[row][col]
        if s == "-" { return false }
        
        while (col < 3) {
            if grid[r][col] != s { return false }
            r += inc
            col += 1
        }
        return true
    }
    
    private func setWinner(fromSymbol s: String)   {
        
        for p in players! {
            if p.symbol == s {
                winner = p.number
                return
            }
        }
        winner = 0
    }
    
    func isGameOver () -> MatchState {
        
        for row in 0...2 {
            let flag = checkRow(row)
            if flag {
                let s = grid[row][0]
                setWinner(fromSymbol: s)
                victoryLine = .row(line: row)
                return .finishedWithWinner
            }
        }
        for col in 0...2 {
            let flag = checkColumn(col)
            if flag {
                let s = grid[0][col]
                setWinner(fromSymbol: s)
                victoryLine = .column(line: col)
                return .finishedWithWinner
            }
        }
        var a = [(row: Int, inc: Int)]()
        a.append((0,  1))
        a.append((2, -1))
        
        for item in a {
            let flag = checkDiagonal(row: item.row, inc: item.inc)
            if flag {
                let s = grid[item.row][0]
                setWinner(fromSymbol: s)
                victoryLine = .diagonal(main: item.row == 0)
                return .finishedWithWinner
            }
        }
        if turn == 9 { return .draw }
        return .onGoing
    }
}
