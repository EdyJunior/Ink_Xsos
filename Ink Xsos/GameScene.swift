//
//  GameScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 01/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

enum VictoryLine {
    
    case row(line: Int)
    case column(line: Int)
    case diagonal(main: Bool)
}

class GameScene: SKScene {

    var modeLabel = SKLabelNode(fontNamed: "DK Flagellum Dei")
    var messageLabel = SKLabelNode(fontNamed: "DK Flagellum Dei")
    var timeLabel = SKLabelNode(fontNamed: "DK Flagellum Dei")
    var symbols = [SKLabelNode]()
    var endGameSprites = [SKSpriteNode]()
    
    var grid = SKSpriteNode()

    override func didMove(to view: SKView) {

        super.didMove(to: view)

        self.buildScene()
    }

    private func buildScene() {
        
        buildTimer()
        buildBackButton()
        buildModeLabel()
        buildGrid()
        buildMessageLabel()
    }
    
    private func buildTimer() {

        let sceneFrame = scene!.frame
        let spotWidth = sceneFrame.width * 0.2859

        let texture = SKTexture(imageNamed: "black")
        let spotTimerSize = CGSize(width: spotWidth, height: spotWidth / 1.0764)
        let spotTimerSprite = SKSpriteNode(texture: texture, color: .white, size: spotTimerSize)
        spotTimerSprite.position = CGPoint(x: 0.87 * sceneFrame.width, y: 0.93 * sceneFrame.height)

        timeLabel.fontSize = spotWidth * 0.4
        timeLabel.position = spotTimerSprite.position
        timeLabel.position.y -= timeLabel.fontSize / 2
        
        spotTimerSprite.zPosition = 1
        timeLabel.zPosition = 2

        addChild(spotTimerSprite)
        addChild(timeLabel)
    }
    
    private func buildBackButton() {
        
        let backButton = Button(defaultButtonImage: "arrow", activeButtonImage: "arrow", buttonAction: backScene)
        
        let sizeButton = CGSize(width: size.width * 0.12, height: size.width * 0.12)
        let positionButton = CGPoint(x: size.width * 0.08, y: size.height * 0.93)
        
        backButton.setSizeAndPosition(sizeButton, position: positionButton, areaFactor: 1.0)
        backButton.touchableArea.zPosition = 1
        backButton.touchableArea.xScale *= -1
        
        addChild(backButton)
    }
    
    private func backScene(_ button: Button) {
        print("Back")
    }
    
    private func buildModeLabel() {
        
        let sceneFrame = scene!.frame
        modeLabel.fontSize = sceneFrame.width * 0.08
        modeLabel.position = CGPoint(x: 0.9 * sceneFrame.midX, y: size.height * 0.915)
        modeLabel.fontColor = UIColor(red: 0, green: 162.0/255, blue: 1, alpha: 1.0)
    
        addChild(modeLabel)
    }
    
    private func buildGrid() {

        let sceneFrame = scene!.frame
        let gridWidth = sceneFrame.width * 0.8

        let texture = SKTexture(imageNamed: "grid")
        let gridSize = CGSize(width: gridWidth, height: gridWidth / 1.0593)

        grid = SKSpriteNode(texture: texture, color: .white, size: gridSize)
        grid.position = CGPoint(x: sceneFrame.midX, y: sceneFrame.midY)

        addChild(grid)
    }
    
    private func buildMessageLabel() {
        
        let sceneFrame = scene!.frame
        messageLabel.fontSize = sceneFrame.width * 0.11
        
        let gridFrame = self.grid.frame
        let gridPosition = self.grid.position
        let timerPosition = self.timeLabel.position
        let gridTop = gridPosition.y + gridFrame.height / 2
        
        messageLabel.position = CGPoint(x: sceneFrame.midX, y: (timerPosition.y + gridTop) / 2.0)
        messageLabel.fontColor = UIColor(red: 97.0/255, green: 216.0/255, blue: 54.0/255, alpha: 1.0)
        
        addChild(messageLabel)
    }

    func draw(texture: SKTexture, atPosition pos: CGPoint, withSize textureSize: CGSize, withAlpha alpha: CGFloat = 1.0, withZPosition zPos: CGFloat = -1.0) {

        let image = SKSpriteNode(texture: texture, color: .white, size: textureSize)
        image.position = pos
        image.alpha = alpha
        image.zPosition = zPos

        addChild(image)
    }

    func draw(text: String, atPosition pos: CGPoint, withSize fontSize: CGFloat, withColor color: UIColor) {

        let label = SKLabelNode(text: text)
        label.fontSize = fontSize
        label.position = pos
        label.zPosition = self.grid.zPosition + 1
        label.fontColor = color
        label.fontName = "DK Flagellum Dei"
        
        symbols.append(label)
        
        addChild(label)
    }
    
    func endGame(victoryLine vl: VictoryLine) {
        
        let splatterTexture = SKTexture(imageNamed: "blueSplatter")
        let splatterSize = CGSize(width: scene!.frame.width * 0.2, height: scene!.frame.width * 1.3)
        let splatter = SKSpriteNode(texture: splatterTexture, color: .blue, size: splatterSize)
        
        var splatterPosition = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        let gridFrame = self.grid.frame
        let gridPosition = self.grid.position
        let gridTop = gridPosition.y + gridFrame.height / 2
        let gridLeft = gridPosition.x - gridFrame.width / 2
        
        switch vl {
        case .row(let line):
            splatter.zRotation = -CGFloat(Double.pi / 2)
            let yAux = CGFloat(2.0 * Double(line) - 1.0)
            splatterPosition = CGPoint(x: gridPosition.x - gridFrame.width * 0.1,
                                       y: gridTop - yAux * gridFrame.height / 6.0)
        case .column(let line):
            let xAux = CGFloat(2.0 * Double(line) - 1.0)
            splatterPosition = CGPoint(x: gridLeft + xAux * gridFrame.width / 6.0,
                                       y: gridPosition.y - gridFrame.height * 0.15)
        case .diagonal(let main):
            splatter.zRotation = CGFloat(Double.pi / 4) * (main ? 1 : -1)
        }
        splatter.position = splatterPosition
        endGameSprites.append(splatter)
        addChild(splatter)
    }
}
