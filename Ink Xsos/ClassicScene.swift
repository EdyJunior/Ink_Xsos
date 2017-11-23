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
        buildScene()
    }
    
    func buildScene() {
        
        //buildResetButton()
        buildCellButtons()
        resetGame()
    }
    
    func buildResetButton() {
        
        let button = Button(defaultButtonImage: "black", activeButtonImage: "black", buttonAction: resetGame)
        
        let buttonPos = CGPoint(x: self.frame.midX,y: self.frame.midY / 6)
        let buttonSize = CGSize(width: self.frame.width / 3, height: self.frame.height / 5)
        
        button.setSizeAndPosition(buttonSize, position: buttonPos, areaFactor: 1.0)
        button.zPosition = 1
        button.name = "Button"
        self.addChild(button)
    }
    
    func resetGame() {
        
        for s in symbols {
            s.removeFromParent()
        }
        for e in endGameSprites {
            e.removeFromParent()
        }
        classic = Classic()
        playerNumber = 1
        modeLabel.text = "classic"
        messageLabel.text = "It’s X turn!"
        timeLabel.text = "15"
    }
    
    func resetGame(_ button: Button) { resetGame() }
    
    func changePlayerNumber() {
        
        if playerNumber == 1 { playerNumber = 2 }
        else { playerNumber = 1 }
        messageLabel.text = "It’s \(classic.getSymbol(fromPlayer: playerNumber)) turn!"
    }
    
    func buildCellButton(inCell cell: [Int], inPos pos: CGPoint) {
        
        let button = Button(buttonAction: touchCell)
        let gridFrame = self.grid.frame
        let buttonSize = CGSize(width: gridFrame.width / 3, height: gridFrame.height / 3)

        button.setSizeAndPosition(buttonSize, position: pos, areaFactor: 1.0)
        button.zPosition = 1
        button.name = "\(cell[0]) \(cell[1])"
        button.touchableArea.alpha = 0.01

        self.addChild(button)
    }
    
    func buildCellButtons() {
        
        for i in 1...3 {
            for j in 1...3 {
                let gridFrame = self.grid.frame
                let gridPosition = self.grid.position
                let gridLeft = gridPosition.x - gridFrame.width / 2
                
                let x = gridLeft
                var xAux = CGFloat((2 * j - 1))
                xAux *= grid.frame.width / 6
                
                var y = (grid.frame.midY - grid.frame.height / 2)
                let yAux = CGFloat(2 * (4 - i) - 1)
                y += (grid.frame.height *  yAux / 6.0)
                
                let point = CGPoint(x: x + xAux, y: y)
                buildCellButton(inCell: [i, j], inPos: point)
            }
        }
    }

    func touchCell(_ button: Button) {

        let btnName = button.name!
        let pos = btnName.components(separatedBy: " ").flatMap { Int($0) }

        let success = classic.updateGrid(playerNumber: playerNumber, symb: (playerNumber == 1 ? "X" : "O"), pos: pos)

        if !success { print("Não é sua vez!") }
        else {
            let s = classic.getSymbol(fromPlayer: playerNumber)
            let size = grid.frame.width / 5.0

            let symbolPosition = CGPoint(x: button.touchableArea.position.x,
                                         y: button.touchableArea.position.y - size * 0.35)
            draw(text: s, atPosition: symbolPosition, withSize: size, withColor: .black)
            let state = classic.isGameOver()
            if state == .finishedWithWinner {
                let message = "Winner = \(s)"
                messageLabel.text = message
                endGame(victoryLine: classic.victoryLine!)
            } else if state == .draw {
                let message = "Draw"
                messageLabel.text = message
            } else if state == .onGoing {
                changePlayerNumber()
            }
        }
    }
}
