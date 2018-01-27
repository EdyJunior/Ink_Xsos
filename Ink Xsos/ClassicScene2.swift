//
//  ClassicScene2.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 26/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class ClassicScene2: GameScene {
    
    var playerNumber = 1;
    var classic = Classic()
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        backgroundColor = .white
        
        if defaultsStandard.soundOn() {
            scene!.run (
                SKAction.playSoundFileNamed(Sounds.start, waitForCompletion: false)
            )
        }
        buildScene()
    }
    
    func buildScene() {
        
        buildCellButtons()
        resetGame()
    }
    
    func resetGame() {
        
        for cb in cellButtons {
            let gridFrame = self.grid.frame
            
            cb.pressed = false
            cb.enabled = true
            cb.size = CGSize(width: gridFrame.width / 3, height: gridFrame.height / 3)
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
    
    func changePlayerNumber() {
        
        if playerNumber == 1 { playerNumber = 2 }
        else { playerNumber = 1 }
        messageLabel.text = "It’s \(classic.getSymbol(fromPlayer: playerNumber)) turn!"
    }
    
    func buildCellButton(inCell cell: [Int], inPos pos: CGPoint) {
        
        let button = Button(buttonAction: touchCell)
        let gridFrame = self.grid.frame
        button.size = CGSize(width: gridFrame.width / 3, height: gridFrame.height / 3)
        button.position = pos
        button.zPosition = 1
        button.name = "\(cell[0]) \(cell[1])"
        button.touchableArea.alpha = 0.01
        
        self.cellButtons.append(button)
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
            button.touchableArea.alpha = 1.0
            
            let s = classic.getSymbol(fromPlayer: playerNumber)
            let atlas = SKTextureAtlas(named: s)
            let n = atlas.textureNames.count
            let imageName = String.init(format: "\(s)_%0.3d", n)
            button.activeButton.texture = SKTexture(imageNamed: imageName)
            
            let correctionFactor = CGFloat(0.6)
            var newSize = button.size
            newSize.width *= correctionFactor
            newSize.height *= correctionFactor
            button.size = newSize
            
            if defaultsStandard.animationsOn() {
                button.animate(AtlasName: s)
            }
            button.enabled = false
            
            let state = classic.isGameOver()
            if state == .finishedWithWinner {
                let message = "\(s) wins"
                messageLabel.text = message
                endGame(victoryLine: classic.victoryLine!)
            } else if state == .draw {
                let message = "Draw"
                messageLabel.text = message
                addResetLabel()
            } else if state == .onGoing {
                changePlayerNumber()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if classic.isGameOver() != .onGoing && finishedEndAnimation {
            resetGame()
        }
    }
    
    override func endGame(victoryLine vl: VictoryLine) {
        
        super.endGame(victoryLine: vl)
        addResetLabel()
    }
    
    func addResetLabel() {
        
        let sceneFrame = scene!.frame
        let resetLabel = SKLabelNode(fontNamed: Fonts.ink)
        resetLabel.fontSize = sceneFrame.width * 0.1
        resetLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.1)
        resetLabel.fontColor = .red
        resetLabel.text = "tap to reset"
        resetLabel.alpha = 0
        
        self.endGameSprites.append(resetLabel)
        addChild(resetLabel)
        
        let interval = defaultsStandard.animationsOn() ? 4.0 : 1.0
        let fadeAction = SKAction.fadeAlpha(to: 1.0, duration: interval)
        resetLabel.run(fadeAction)
    }
}
