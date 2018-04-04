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
    func updateMessageLabel()
}

class ClassicScene: GameScene {
    
    var playerNumber = 1;
    var classic = ClassicGame()
    var nodesOfOptions = [SKNode]()
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        backgroundColor = .white
        
        if defaultsStandard.soundOn() {
            scene!.run (
                SKAction.playSoundFileNamed(Sounds.start, waitForCompletion: false)
            )
        }
        scoreBoard = Scoreboard(sceneFrame: scene!.frame, hasAi: hasAI)
        scoreBoard.position = CGPoint(x: scene!.frame.width / 2, y: scene!.frame.height / 2)
        addChild(scoreBoard)
        resetGame()
        
        let optionsAction = OptionsAction(scene: scene!)
        optionsAction.addOptionsButton()
    }
    
    func resetGame() {
        
        for e in endGameSprites { e.removeFromParent() }
        endGameSprites.removeAll()
        
        classic = ClassicGame()
        var player1, player2: PlayerEntity
        if hasAI {
            let random = arc4random_uniform(2)
            if random == 0 {
                player1 = ClassicPlayer(symbol: "X", number: 0, brush: .black, delegate: classic)
                player2 = ClassicAI(symbol: "O", number: 1, brush: .black, delegate: classic)
            } else {
                player1 = ClassicAI(symbol: "X", number: 0, brush: .black, delegate: classic)
                player2 = ClassicPlayer(symbol: "O", number: 1, brush: .black, delegate: classic)
                classic.typeOfPlayers = .secondHuman
            }
        } else {
            player1 = ClassicPlayer(symbol: "X", number: 0, brush: .black, delegate: classic)
            player2 = ClassicPlayer(symbol: "O", number: 1, brush: .black, delegate: classic)
            classic.typeOfPlayers = .onlyHumans
        }
        classic.players = [player1, player2]
        classic.gridUpdater = self
        classic.matchManager = self
        grid.gridProtocol = classic
        
        playerNumber = 1
        modeLabel.text = "classic"
        messageLabel.text = "Loading game..."
        grid.clear()
        grid.lock(false)
        finishedEndAnimation = false
        matchNumber += 1
        
        if matchNumber > 1 { classic.passTurn() }
        scoreBoard.alpha = 1
        scoreBoard.updateScore()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if classic.winner > -1 && finishedEndAnimation {
            resetGame()
        }
    }
    
    func endGame() {
        
        if hasAI {
            var winner = ""
            switch classic.typeOfPlayers {
            case .firstHuman:
                scoreBoard.score1 += classic.currentPlayer.symbol == "X" ? 1 : 0
                scoreBoard.score2 += classic.currentPlayer.symbol == "X" ? 0 : 1
                winner = classic.currentPlayer.symbol == "X" ? Images.Spots.you_win_splash : Images.Spots.you_lose_splash
                break
            default:
                scoreBoard.score1 += classic.currentPlayer.symbol == "O" ? 1 : 0
                scoreBoard.score2 += classic.currentPlayer.symbol == "O" ? 0 : 1
                winner = classic.currentPlayer.symbol == "X" ? Images.Spots.you_lose_splash : Images.Spots.you_win_splash
            }
            presentEndAnimation(winner: winner)
        } else {
            scoreBoard.score1 += classic.currentPlayer.symbol == "X" ? 1 : 0
            scoreBoard.score2 += classic.currentPlayer.symbol == "X" ? 0 : 1
            let winner = classic.currentPlayer.symbol == "X" ? Images.Spots.X_wins_splash : Images.Spots.O_wins_splash
            presentEndAnimation(winner: winner)
        }
        messageLabel.text = "It's over"
        addResetLabel(interval: 2.7)
    }
    
    func addResetLabel(interval: Double = 0.7) {
        
        scoreBoard.alpha = 0
        let sceneFrame = scene!.frame
        let resetLabel = SKLabelNode(fontNamed: Fonts.ink)
        resetLabel.fontSize = sceneFrame.width * 0.1
        resetLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.1)
        resetLabel.fontColor = Colors.red
        resetLabel.text = "tap to reset"
        resetLabel.alpha = 0
        
        self.endGameSprites.append(resetLabel)
        addChild(resetLabel)
        
        resetLabel.run(SKAction.fadeAlpha(to: 1.0, duration: interval))
    }
}

extension ClassicScene: GridUpdater {
    
    func updateGrid(symb: String, row: Int, column col: Int) {
        grid.draw(symbolName: symb, row: row, column: col, animated: defaultsStandard.animationsOn())
    }
    
    func lockGrid(_ flag: Bool) { self.grid.lock(flag) }
}

extension ClassicScene: MatchPresentationManager {
    
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
    
    func passTurn() { grid.lock(false) }
    
    func updateMessageLabel() {
        
        var nowPlay = ""
        if hasAI {
            switch classic.typeOfPlayers {
            case .firstHuman:
                nowPlay = classic.currentPlayer.symbol == "X" ? "your" : "AI"
            default:
                nowPlay = classic.currentPlayer.symbol == "O" ? "your" : "AI"
            }
        } else { nowPlay = classic.currentPlayer.symbol }
        messageLabel.text = "It's \(nowPlay) turn!"
    }
    
    func presentEndAnimation(winner: String) {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 1.0 : 1.0

        let w = scene!.frame.width
        let sw = w * factor
        let texture = SKTexture(imageNamed: "\(winner)_001")
        let proportion = texture.size().height / texture.size().width
        let endSplatterSize = CGSize(width: sw, height: sw * proportion)
        let endSplatterPosition = CGPoint(x: w * 0.5, y: scene!.frame.midY)
        let endSplatter = SKSpriteNode(texture: texture, color: .clear, size: endSplatterSize)
        endSplatter.position = endSplatterPosition
        endSplatter.zPosition = self.grid.zPosition + 3
        addChild(endSplatter)
        endGameSprites.append(endSplatter)
        
        let animationAction = endSplatter.animation(atlasName: winner, duration: 0.5)
        let playSound = SKAction.playSoundFileNamed(Sounds.end, waitForCompletion: false)
        endSplatter.run(SKAction.group([animationAction, playSound]))
    }
}
