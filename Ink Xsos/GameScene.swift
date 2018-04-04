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
    var hasAI: Bool!
    
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
        
        let gridZPos = grid.zPosition
        let w = scene!.frame.width
        let h = scene!.frame.height
        let texture1 = SKTexture(imageNamed: "splash_001")
        let texture2 = SKTexture(imageNamed: "splash_002")
        let texture3 = SKTexture(imageNamed: "splash_006")
        let position1 = CGPoint(x: w * 1.15, y: h)
        let position2 = CGPoint(x: -w * 0.2, y: h * 0.4)
        let position3 = CGPoint(x: w * 1.2, y: h * 0.2)
        let proportion = texture1.size().height / texture1.size().width
        let splashesSize = CGSize(width: w, height: w * proportion)
        
        let splash1 = SKSpriteNode(texture: texture1, color: .clear, size: splashesSize)
        let splash2 = SKSpriteNode(texture: texture2, color: .clear, size: splashesSize)
        let splash3 = SKSpriteNode(texture: texture3, color: .clear, size: splashesSize)
        splash1.position = position1
        splash2.position = position2
        splash3.position = position3
        splash1.zPosition = gridZPos - 1
        splash2.zPosition = gridZPos - 1
        splash3.zPosition = gridZPos - 1
        splash1.alpha = 0
        splash2.alpha = 0
        splash3.alpha = 0
        
        addChild(splash1)
        addChild(splash2)
        addChild(splash3)
        
        let wait = SKAction.wait(forDuration: 0.3)
        let fade = SKAction.fadeAlpha(to: 1.0, duration: 0.3)
        let act1 = SKAction.run { splash1.run(fade) }
        let act2 = SKAction.run { splash2.run(fade) }
        let act3 = SKAction.run { splash3.run(fade) }
        let act = SKAction.sequence([act1, wait, act2, wait, act3])
        scene?.run(act)
    }
    
    private func buildModeLabel() {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.1 : 0.08
        
        let sceneFrame = scene!.frame
        modeLabel.fontSize = sceneFrame.width * factor
        modeLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.915)
        modeLabel.fontColor = Colors.blue
        
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
        messageLabel.fontColor = Colors.green
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
}
