//
//  GameScene2.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 26/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var modeLabel = SKLabelNode(fontNamed: Fonts.ink)
    var messageLabel = SKLabelNode(fontNamed: Fonts.ink)
    var endGameSprites = [SKNode]()
    var finishedEndAnimation = false
    var grid = ClassicGrid()
    var matchNumber = 0
    var scoreBoard: Scoreboard!
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        self.buildScene()
    }
    
    private func buildScene() {
        
        setupGrid()
        buildBackground()
        buildModeLabel()
        buildMessageLabel()
    }
    
    private func buildBackground() {
        
        let background = SKSpriteNode(texture: SKTexture(imageNamed: Images.background), color: .white, size: scene!.size)
        background.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        background.zPosition = -2
        addChild(background)
    }
    
    private func buildModeLabel() {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.1 : 0.08
        
        let sceneFrame = scene!.frame
        modeLabel.fontSize = sceneFrame.width * factor
        modeLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.915)
        modeLabel.fontColor = UIColor(red: 0, green: 162.0/255, blue: 1, alpha: 1.0)
        
        addChild(modeLabel)
    }
    
    private func buildMessageLabel() {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.11 : 0.08
        let sceneFrame = scene!.frame
        let fontSize = sceneFrame.width * factor
        messageLabel.fontSize = fontSize
        
        let gridFrame = self.grid.frame
        let gridPosition = self.grid.position
        let modePosition = self.modeLabel.position
        let gridTop = gridPosition.y + gridFrame.height
        
        messageLabel.verticalAlignmentMode = .center
        messageLabel.position = CGPoint(x: sceneFrame.midX, y: (gridTop + modePosition.y) / 2)
        messageLabel.fontColor = UIColor(red: 72.0/255, green: 161.0/255, blue: 41.0/255, alpha: 1.0)
        messageLabel.zPosition = 10
        
        addChild(messageLabel)
    }
    
    func setupGrid() {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.8 : 0.6
        let sceneFrame = scene!.frame
        let gridSize = sceneFrame.width * factor
        let gridXPosition = sceneFrame.width / 2 - gridSize / 2
        let gridYPosition = sceneFrame.height / 2 - gridSize / 2
        
        grid = ClassicGrid(size: CGSize(width: gridSize, height: gridSize))
        if defaultsStandard.animationsOn() {
            grid.animate()
        } else { grid.setImage() }
        grid.position = CGPoint(x: gridXPosition, y: gridYPosition)
        
        addChild(grid)
    }
    
    func endGame() { if defaultsStandard.animationsOn() { animateEnd() } }
    
    func animateEnd() {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.25 : 0.2
        
        let spotTexture = SKTexture(imageNamed: Images.Spots.bigBlack)
        let spotSize = CGSize(width: scene!.frame.width * 2.5, height: scene!.frame.width * 1.0)
        let spotPosition = CGPoint(x: scene!.frame.width * 0.7, y: scene!.frame.midY)
        let inkSpot = SKSpriteNode(texture: spotTexture, color: .black, size: spotSize)
        inkSpot.position = spotPosition
        inkSpot.zPosition = self.grid.zPosition + 3
        
        let firstMessage = SKLabelNode(text: "It's")
        firstMessage.fontSize = inkSpot.frame.height * factor
        firstMessage.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY + inkSpot.frame.height * 0.01)
        firstMessage.zPosition = inkSpot.zPosition + 1
        firstMessage.fontColor = .white
        firstMessage.fontName = Fonts.ink
        
        let secondMessage = SKLabelNode(text: "Over")
        secondMessage.fontSize = inkSpot.frame.height * factor
        secondMessage.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY - inkSpot.frame.height * 0.2)
        secondMessage.zPosition = inkSpot.zPosition + 1
        secondMessage.fontColor = .white
        secondMessage.fontName = Fonts.ink
        
        let addSpot = SKAction.run {
            self.addChild(inkSpot)
            self.endGameSprites.append(inkSpot)
        }
        let addMessage1 = SKAction.run {
            self.addChild(firstMessage)
            self.endGameSprites.append(firstMessage)
        }
        let addMessage2 = SKAction.run {
            self.addChild(secondMessage)
            self.endGameSprites.append(secondMessage)
        }
        let wait = SKAction.wait(forDuration: 0.5)
        let playSound = defaultsStandard.soundOn() ?
            SKAction.playSoundFileNamed(Sounds.end, waitForCompletion: false) :
            SKAction()
        let seqAction = SKAction.sequence([wait, addSpot, wait, addMessage1, wait, addMessage2])
        let group = SKAction.group([playSound, seqAction])
        
        scene!.run(group)
    }
}
