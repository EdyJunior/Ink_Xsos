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

    var modeLabel = SKLabelNode(fontNamed: Fonts.ink)
    var messageLabel = SKLabelNode(fontNamed: Fonts.ink)
    var timeLabel = SKLabelNode(fontNamed: Fonts.ink)
    var cellButtons = [Button]()
    var endGameSprites = [SKNode]()
    
    var grid = SKSpriteNode()
    var finishedEndAnimation = true
    
    var soundController: SoundController?

    override func didMove(to view: SKView) {

        super.didMove(to: view)

        self.buildScene()
    }

    private func buildScene() {
        
        buildBackground()
        buildGrid()
        //buildTimer()  It will be useful soon
        buildBackButton()
        buildModeLabel()
        buildMessageLabel()
    }
    
    private func buildBackground() {
        
        let background = SKSpriteNode(texture: SKTexture(imageNamed: Images.background), color: .white, size: scene!.size)
        background.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        background.zPosition = -2
        addChild(background)
    }
    
    //It will be useful soon
    private func buildTimer() {

        let sceneFrame = scene!.frame
        let spotWidth = sceneFrame.width * 0.2859

        let texture = SKTexture(imageNamed: Images.Spots.black)
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
        
        let backButton = Button(defaultButtonImage: Images.arrow, activeButtonImage: Images.arrow) { _ in
            guard let view = self.view else { return }
            
            let sceneInstance = MinimalistMenuScene(size: view.bounds.size)
            sceneInstance.soundController = self.soundController
            let transition = SKTransition.fade(with: .white, duration: 1.0)
//            if defaultsStandard.soundOn() {
//                self.soundController?.playSound()
//            }
            view.presentScene(sceneInstance, transition: transition)
        }
        
        backButton.size = CGSize(width: size.width * 0.12, height: size.width * 0.12)
        backButton.position = CGPoint(x: size.width * 0.08, y: size.height * 0.93)
        
        backButton.touchableArea.zPosition = 1
        backButton.touchableArea.xScale *= -1
        
        addChild(backButton)
    }
    
    private func buildModeLabel() {
        
        let sceneFrame = scene!.frame
        modeLabel.fontSize = sceneFrame.width * 0.1
        modeLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.915)
        modeLabel.fontColor = UIColor(red: 0, green: 162.0/255, blue: 1, alpha: 1.0)
    
        addChild(modeLabel)
    }
    
    private func buildGrid() {

        let sceneFrame = scene!.frame
        let gridWidth = sceneFrame.width * 0.8
        
        let textures = SKTextureAtlas(named: Images.grid)
        var frames = [SKTexture]()
        
        let numImages = textures.textureNames.count
        let imageName = "\(Images.grid)_%0.3d"
        let texture = SKTexture(imageNamed: String.init(format: imageName, numImages))
        let gridSize = CGSize(width: gridWidth, height: gridWidth / 1.0593)

        grid = SKSpriteNode(texture: texture, color: .black, size: gridSize)
        grid.position = CGPoint(x: sceneFrame.midX, y: sceneFrame.midY)

        addChild(grid)
        
        if defaultsStandard.animationsOn() {
            for i in 1...numImages {
                let name = String.init(format: imageName, i)
                frames.append(SKTexture(imageNamed: name))
            }
            let action = SKAction.animate(with: frames,
                                 timePerFrame: 1.0 / Double(numImages),
                                 resize: false,
                                 restore: false)
            grid.run(action)
        }
    }
    
    private func buildMessageLabel() {
        
        let sceneFrame = scene!.frame
        messageLabel.fontSize = sceneFrame.width * 0.11
        
        let gridFrame = self.grid.frame
        let gridPosition = self.grid.position
        let modePosition = self.modeLabel.position
        let gridTop = gridPosition.y + gridFrame.height / 2
        
        messageLabel.position = CGPoint(x: sceneFrame.midX, y: (modePosition.y + gridTop) / 2.0)
        messageLabel.fontColor = UIColor(red: 97.0/255, green: 216.0/255, blue: 54.0/255, alpha: 1.0)
        messageLabel.zPosition = 10
        
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
        label.fontName = Fonts.ink

        addChild(label)
    }
    
    func endGame(victoryLine vl: VictoryLine) {
        
        finishedEndAnimation = false
        
        for button in self.cellButtons {
            button.enabled = false
        }
        
        let textures = SKTextureAtlas(named: Images.splatter)
        var frames = [SKTexture]()
        
        let numImages = textures.textureNames.count
        let imageName = "\(Images.splatter)_%0.3d"
        
        let splatterSize = CGSize(width: scene!.frame.width * 0.2, height: scene!.frame.width * 1.3)
        let splatter = SKSpriteNode(imageNamed: String.init(format: imageName, numImages))
        splatter.size = splatterSize
        splatter.colorBlendFactor = 1.0
        splatter.color = UIColor(red: 0, green: 162.0/255, blue: 1, alpha: 1.0)
        
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
        splatter.zPosition = self.grid.zPosition + 2
        splatter.alpha = 0.8
        splatter.isUserInteractionEnabled = false
        
        if defaultsStandard.animationsOn() {
            for i in 1...numImages {
                let name = String.init(format: imageName, i)
                frames.append(SKTexture(imageNamed: name))
            }
            let action = SKAction.animate(with: frames,
                                          timePerFrame: 0.25 / Double(numImages),
                                          resize: false,
                                          restore: false)
            splatter.run(action)
        }
        endGameSprites.append(splatter)
        addChild(splatter)

        if defaultsStandard.animationsOn() { animateEnd() }
        else { self.finishedEndAnimation = true }
    }
    
    func animateEnd() {
        
        let spotTexture = SKTexture(imageNamed: Images.Spots.bigBlack)
        let spotSize = CGSize(width: scene!.frame.width * 2.5, height: scene!.frame.width * 1.0)
        let spotPosition = CGPoint(x: scene!.frame.width * 0.7, y: scene!.frame.midY)
        let inkSpot = SKSpriteNode(texture: spotTexture, color: .black, size: spotSize)
        inkSpot.position = spotPosition
        inkSpot.zPosition = self.grid.zPosition + 3
        
        let firstMessage = SKLabelNode(text: "It's")
        firstMessage.fontSize = inkSpot.frame.height * 0.25
        firstMessage.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY + inkSpot.frame.height * 0.01)
        firstMessage.zPosition = inkSpot.zPosition + 1
        firstMessage.fontColor = .white
        firstMessage.fontName = Fonts.ink
        
        let secondMessage = SKLabelNode(text: "Over")
        secondMessage.fontSize = inkSpot.frame.height * 0.25
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
        let wait = SKAction.wait(forDuration: 1)
        let playSound = defaultsStandard.soundOn() ?
                        SKAction.playSoundFileNamed(Sounds.end, waitForCompletion: false) :
                        SKAction()
        let seqAction = SKAction.sequence([wait, addSpot, wait, addMessage1, wait, addMessage2])
        let group = SKAction.group([playSound, seqAction])
        let finish = SKAction.run { self.finishedEndAnimation = true }
        
        scene!.run(SKAction.sequence([group, finish]))
    }
}
