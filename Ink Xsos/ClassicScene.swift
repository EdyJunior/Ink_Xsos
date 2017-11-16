//
//  ClassicScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 07/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class ClassicScene: GameScene {

    var playerNumber = 1;
    var classic = Classic()
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        backgroundColor = .white
        buildScene()
    }
    
    func buildScene() {
        
        buildResetButton()
        buildCellButtons()
    }
    
    func buildResetButton() {
        
        let button = Button(defaultButtonImage: "spot", activeButtonImage: "spot", buttonAction: resetGame)
        
        button.size = CGSize(width: self.frame.width / 3, height: self.frame.height / 5)
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY / 6)
        button.zPosition = 1
        button.name = "Button"
        self.addChild(button)
    }
    
    func resetGame(_ button: Button) {
        
        for s in symbols {
            s.removeFromParent()
        }
        classic = Classic()
        playerNumber = 1
    }
    
    func changePlayerNumber() {
        
        if playerNumber == 1 { playerNumber = 2 }
        else { playerNumber = 1 }
        print(playerNumber)
        messageLabel.text = "It’s \(classic.getSymbol(fromPlayer: playerNumber)) turn!"
    }
    
    func buildCellButton(inCell cell: [Int], inPos pos: CGPoint) {
        
        let button = Button(defaultButtonImage: "spot", activeButtonImage: "spot", buttonAction: touchCell)
        
        button.size = CGSize(width: self.frame.width / 3, height: self.frame.height / 5)
        button.position = pos
        button.zPosition = 1
        button.name = "\(cell[0]) \(cell[1])"
        button.touchableArea.alpha = 0.01

        self.addChild(button)
    }
    
    func buildCellButtons() {
        
        for i in 1...3 {
            for j in 1...3 {
                var x = CGFloat((2 * j - 1))
                x *= grid.frame.width / 4.75
                
                var y = (grid.frame.midY - grid.frame.height / 2)
                let yAux = CGFloat(2 * (4 - i) - 1)
                y += (grid.frame.height *  yAux / 6.0)
                
                let point = CGPoint(x: x, y: y)
                buildCellButton(inCell: [i, j], inPos: point)
            }
        }
    }

    func touchCell(_ button: Button) {

        let btnName = button.name!

        var pos = btnName.components(separatedBy: " ").flatMap { Int($0) }
        print("\(pos[0]); \(pos[1])")

        let success = classic.updateGrid(playerNumber: playerNumber, symb: (playerNumber == 1 ? "X" : "O"), pos: pos)

        if !success { print("Não é sua vez!") }
        else {
            for row in classic.grid {
                print(row)
            }
            let s = classic.getSymbol(fromPlayer: playerNumber)
            let size = grid.frame.width / 5.0

            draw(text: s, atPosition: button.position, withSize: size, withColor: .black)
            if classic.isGameOver() == .finishedWithWinner {
                let winner = classic.winner
                let message = "Winner = \(winner)"
                print(message)
            } else if classic.isGameOver() == .draw {
                let message = "Draw"
                print(message)
            } else { changePlayerNumber() }
        }
    }
}
