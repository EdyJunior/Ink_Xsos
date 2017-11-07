//
//  ClassicScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 07/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class ClassicScene: SKScene {

    var playerNumber = 1;
    var classic = Classic()
    
    override func didMove(to view: SKView) {
        buildScene()
    }
    
    func buildScene() {
        
        buildPlayerButton()
        buildGrid()
    }
    
    func buildPlayerButton() {
        
        let button = Button(defaultButtonImage: "spot", activeButtonImage: "spot", buttonAction: changePlayerNumber)
        
        let buttonPos = CGPoint(x: self.frame.midX,y: self.frame.midY / 6)
        let buttonSize = CGSize(width: self.frame.width / 3, height: self.frame.height / 5)
        
        button.setSizeAndPosition(buttonSize, position: buttonPos, areaFactor: 1.0)
        button.zPosition = 1
        button.name = "Button"
        self.addChild(button)
    }
    
    func changePlayerNumber(_ button: Button) {
        
        if playerNumber == 1 { playerNumber = 2 }
        else { playerNumber = 1 }
        print(playerNumber)
    }
    
    func buildGrid() {
        
        for i in 1...3 {
            for j in 1...3 {
                buildCellButton(inPos: [i, j])
            }
        }
    }
    
    func buildCellButton(inPos pos: [Int]) {
        
        let button = Button(defaultButtonImage: "spot", activeButtonImage: "spot", buttonAction: touchCell)
        
        let buttonPos = CGPoint(x: CGFloat(pos[1]) * self.frame.width / 3.0,y: CGFloat(4 - pos[0]) * self.frame.height / 3.0)
        let buttonSize = CGSize(width: self.frame.width / 3, height: self.frame.height / 5)
        
        button.setSizeAndPosition(buttonSize, position: buttonPos, areaFactor: 1.0)
        button.zPosition = 1
        button.name = "\(pos[0]) \(pos[1])"
        
        self.addChild(button)
    }
    
    func touchCell(_ button: Button) {
        
        let btnName = button.name!
        
        var pos = btnName.components(separatedBy: " ").flatMap { Int($0) }
        print("\(pos[0]); \(pos[1])")
        
        let success = classic.updateGrid(playerNumber: playerNumber, symb: (playerNumber == 1 ? "X" : "O"), pos: pos)
        
        for row in classic.grid {
            print(row)
        }
        
        if !success { print("Não é sua vez!") }
        
        if classic.isGameOver() {
            let winner = classic.winner
            let message = (winner == 0 ? "Draw" : "Winner = \(classic.winner)")
            
            print(message)
        }
    }
}
