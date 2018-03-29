//
//  ClassicGame.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 25/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import Foundation
import SpriteKit

enum MatchState {
    case finishedWithWinner, onGoing, draw
}

enum TypeOfPlayers {
    case firstHuman, secondHuman, onlyHumans
}

class ClassicGame {
    
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
    
    typealias symbolType = String
    
    init() {
        
        for _ in 0...2 { grid.append(["-", "-", "-"]) }
        self.turn = 0
    }
    
    func isEmpty(_ row: Int, _ column: Int) -> Bool {
        return grid[row][column] == "-"
    }
    
    func getSymbol(fromPlayer p: Int) -> String {
        
        let desiredPlayer = players?.filter() { $0.number == p }
        return desiredPlayer![0].symbol
    }
    
    private func checkRow (_ row: Int, for symbol: String) -> Bool {
        return grid[row][0] == symbol && grid[row][1] == symbol && grid[row][2] == symbol
    }
    
    private func checkColumn (_ col: Int, for symbol: String) -> Bool {
        return grid[0][col] == symbol && grid[1][col] == symbol && grid[2][col] == symbol
    }
    
    private func checkDiagonal1 (for symbol: String) -> Bool {
        return grid[0][0] == symbol && grid[1][1] == symbol && grid[2][2] == symbol
    }
    
    private func checkDiagonal2 (for symbol: String) -> Bool {
        return grid[2][0] == symbol && grid[1][1] == symbol && grid[0][2] == symbol
    }
    
    func isGameOver () -> MatchState {
        
        for i in [0, 1] {
            let symbol = players![i].symbol
            for j in 0...2 {
                if checkRow(j, for: symbol) {
                    setWinner(fromSymbol: symbol)
                    victoryLine = .row(line: j)
                    return .finishedWithWinner
                }
                if checkColumn(j, for: symbol) {
                    setWinner(fromSymbol: symbol)
                    victoryLine = .column(line: j)
                    return .finishedWithWinner
                }
            }
            if checkDiagonal1(for: symbol) {
                setWinner(fromSymbol: symbol)
                victoryLine = .diagonal(main: true)
                return .finishedWithWinner
            }
            if checkDiagonal2(for: symbol) {
                setWinner(fromSymbol: symbol)
                victoryLine = .diagonal(main: false)
                return .finishedWithWinner
            }
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
        
        if isEmpty(row, col) {
            grid[row][col] = symb
            gridUpdater?.updateGrid(symb: symb, row: row, column: col)
        } else if !isEmpty(row, col) && winner == -1 {
            gridUpdater?.lockGrid(false)
        }
    }
    
    func entityMoves(_ row: Int, _ col: Int) {
        
        gridUpdater?.lockGrid(true)
        let cp = self.turn % 2 == 0 ? 1 : 0
        updateGrid(symb: players![cp].symbol, row: row, column: col)
    }
    
    func passTurn() { turn += 1 }
}

extension ClassicGame: GridDelegate {
    
    func touchIn(_ row: Int, _ col: Int) {
        entityMoves(row, col)
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

extension ClassicGame: PlayDelegate {
    
    func move(row: Int, column: Int) {
        entityMoves(row, column)
    }
}
