//
//  ClassicScene2.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 26/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

protocol GridUpdater {
    func updateGrid(symb: String, row: Int, column col: Int)
}

protocol MatchPresentationManager {
    
    func show(winner: PlayerEntity, victoryLine vl: VictoryLine)
    func showDraw()
    func passTurn()
}

class ClassicScene2: GameScene2 {
    
    var playerNumber = 1;
    var classic = ClassicGame()
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        backgroundColor = .white
        
        if defaultsStandard.soundOn() {
            scene!.run (
                SKAction.playSoundFileNamed(Sounds.start, waitForCompletion: false)
            )
        }
        resetGame()
    }
    
    func resetGame() {
        
        for e in endGameSprites { e.removeFromParent() }
        endGameSprites.removeAll()
        
        classic = ClassicGame()
        let player1 = ClassicPlayer(symbol: "X", number: 0, brush: .black)
        let player2 = ClassicPlayer(symbol: "O", number: 1, brush: .black)
        classic.players = [player1, player2]
        classic.gridUpdater = self
        classic.matchManager = self
        grid.touchedProtocol = classic
        
        playerNumber = 1
        modeLabel.text = "classic"
        messageLabel.text = "It’s X turn!"
        grid.clear()
        grid.lock(false)
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

extension ClassicScene2: GridUpdater {
    
    func updateGrid(symb: String, row: Int, column col: Int) {
        grid.draw(symbolName: symb, row: row, column: col, animated: defaultsStandard.animationsOn())
    }
}

extension ClassicScene2: MatchPresentationManager {
    
    func show(winner: PlayerEntity, victoryLine vl: VictoryLine) {
        
        grid.add(victoryLine: vl, animated: defaultsStandard.animationsOn())
        
        let wait = SKAction.wait(forDuration: 0.4)
        let endAction = SKAction.run { self.endGame(victoryLine: vl) }
        
        run(SKAction.sequence([wait, endAction]))
    }
    
    func showDraw() {
        
    }
    
    func passTurn() {
        
    }
}
