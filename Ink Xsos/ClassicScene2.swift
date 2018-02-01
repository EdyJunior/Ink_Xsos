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
    func lockGrid(_ flag: Bool)
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
        finishedEndAnimation = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if classic.winner > -1 && finishedEndAnimation {
            resetGame()
        }
    }
    
    override func endGame() {
        
        super.endGame()
        messageLabel.text = "\(classic.currentPlayer.symbol) wins!"
        addResetLabel(interval: 2.7)
    }
    
    func addResetLabel(interval: Double = 0.7) {
        
        let sceneFrame = scene!.frame
        let resetLabel = SKLabelNode(fontNamed: Fonts.ink)
        resetLabel.fontSize = sceneFrame.width * 0.1
        resetLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.1)
        resetLabel.fontColor = .red
        resetLabel.text = "tap to reset"
        resetLabel.alpha = 0
        
        self.endGameSprites.append(resetLabel)
        addChild(resetLabel)
        
        resetLabel.run(SKAction.fadeAlpha(to: 1.0, duration: interval))
    }
}

extension ClassicScene2: GridUpdater {
    
    func updateGrid(symb: String, row: Int, column col: Int) {
        grid.draw(symbolName: symb, row: row, column: col, animated: defaultsStandard.animationsOn())
    }
    
    func lockGrid(_ flag: Bool) { self.grid.lock(flag) }
}

extension ClassicScene2: MatchPresentationManager {
    
    func show(winner: PlayerEntity, victoryLine vl: VictoryLine) {
        
        grid.add(victoryLine: vl, animated: defaultsStandard.animationsOn())
        
        let wait = SKAction.wait(forDuration: 0.4)
        let endAction = SKAction.run { self.endGame() }
        let sequence1 = SKAction.sequence([wait, endAction])
        
        let interval = defaultsStandard.animationsOn() ? 2.7 : 0.7
        let waitEndAnimation = SKAction.wait(forDuration: interval)
        let unlock = SKAction.run { self.finishedEndAnimation = true }
        
        let sequence2 = SKAction.sequence([waitEndAnimation, unlock])
        
        run(SKAction.group([sequence1, sequence2]))
    }
    
    func showDraw() {
        
        addResetLabel()
        messageLabel.text = "Draw!"
        
        let wait = SKAction.wait(forDuration: 0.7)
        let unlock = SKAction.run { self.finishedEndAnimation = true }
        
        run(SKAction.sequence([wait, unlock]))
    }
    
    func passTurn() {
        
        messageLabel.text = "It's \(classic.currentPlayer.symbol) turn!"
        grid.lock(false)
    }
}
