//
//  NumericGame.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 26/03/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import Foundation
import SpriteKit

class NumericGame {
    
    var players: [PlayerEntity]?
    var turn: Int {
        
        didSet {
            if turn != 0 && winner == -1 {
                matchManager!.updateMessageLabel()
                let cp = self.turn % 2 == 0 ? 1 : 0
                self.players?[cp].play(grid: self.grid)
            }
        }
    }
    var time: TimeInterval = 0
    var grid = [[String]]()
    var winner: Int = -1
    var currentPlayer: PlayerEntity {
        
        let cp = self.turn % 2 == 0 ? 1 : 0
        return players![cp]
    }
    var victoryLine: VictoryLine?
    var gridUpdater: GridUpdater?
    var matchManager: MatchPresentationManager?
    var typeOfPlayers = TypeOfPlayers.firstHuman
    var available = [String]()
    
    init() {
        
        for _ in 0...2 { grid.append(["-", "-", "-"]) }
        for i in 1...9 { available.append("\(i)") }
        self.turn = 0
    }
    
    func isEmpty(_ row: Int, _ column: Int) -> Bool {
        return grid[row][column] == "-"
    }
    
    func getSymbol(fromPlayer p: Int) -> String {
        
        let desiredPlayer = players?.filter() { $0.number == p }
        return desiredPlayer![0].symbol
    }
    
    private func checkRow (_ row: Int) -> Bool {
        
        let a = Int(grid[row][0])!
        let b = Int(grid[row][1])!
        let c = Int(grid[row][2])!
        return a + b + c == 15
    }
    
    private func checkColumn (_ col: Int) -> Bool {
        
        let a = Int(grid[0][col])!
        let b = Int(grid[1][col])!
        let c = Int(grid[2][col])!
        return a + b + c == 15
    }
    
    private func checkDiagonal1 () -> Bool {
        
        let a = Int(grid[0][0])!
        let b = Int(grid[1][1])!
        let c = Int(grid[2][2])!
        return a + b + c == 15
    }
    
    private func checkDiagonal2 () -> Bool {
        
        let a = Int(grid[2][0])!
        let b = Int(grid[1][1])!
        let c = Int(grid[0][2])!
        return a + b + c == 15
    }
    
    func isGameOver () -> MatchState {
        
        for j in 0...2 {
            if checkRow(j) {
                setWinner(fromSymbol: currentPlayer.symbol)
                victoryLine = .row(line: j)
                return .finishedWithWinner
            }
            if checkColumn(j) {
                setWinner(fromSymbol: currentPlayer.symbol)
                victoryLine = .column(line: j)
                return .finishedWithWinner
            }
        }
        if checkDiagonal1() {
            setWinner(fromSymbol: currentPlayer.symbol)
            victoryLine = .diagonal(main: true)
            return .finishedWithWinner
        }
        if checkDiagonal2() {
            setWinner(fromSymbol: currentPlayer.symbol)
            victoryLine = .diagonal(main: false)
            return .finishedWithWinner
        }
        if turn == 9 {
            winner = 3
            return .draw
        }
        return .onGoing
    }
    
    private func setWinner(fromSymbol s: String)   {
        
        for p in players! {
            if p.symbol == s {
                winner = p.number
                return
            }
        }
        winner = 2
    }
    
    func updateGrid (symb: String, row: Int, column col: Int) {
        
        if isEmpty(row, col) && available.contains(symb) {
            grid[row][col] = symb
            gridUpdater?.updateGrid(symb: symb, row: row, column: col)
            available.remove(at: available.index(of: symb)!)
        } else if !isEmpty(row, col) && winner == -1 {
            gridUpdater?.lockGrid(false)
        }
    }
    
    func entityMoves(_ row: Int, _ col: Int, _ symbol: String) {
        
        gridUpdater?.lockGrid(true)
        updateGrid(symb: symbol, row: row, column: col)
    }
    
    func passTurn() { turn += 1 }
}

extension NumericGame: GridDelegate {
    
    func touchIn(_ row: Int, _ col: Int, _ symbol: String) {
        entityMoves(row, col, symbol)
    }
    
    func finishedSymbol() {
        
        let state = isGameOver()
        switch state {
        case .finishedWithWinner:
            matchManager!.show(winner: players![winner], victoryLine: victoryLine!)
        case .draw:
            matchManager!.showDraw()
        default:
            self.matchManager!.passTurn()
            self.passTurn()
        }
    }
    
    func finishedGrid() { turn = 1 }
}

extension NumericGame: PlayDelegate {
    
    func move(row: Int, column: Int, symbol: String) {
        entityMoves(row, column, symbol)
    }
}
