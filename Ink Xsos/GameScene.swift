//
//  GameScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 01/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var modeLabel = SKLabelNode(text: "Mode: ")
    var messageLabel = SKLabelNode(text: "It’s your turn!")
    var timeLabel = SKLabelNode(text: "30")

    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        self.buildScene()
    }
    
    private func buildScene() {
        
        buildTimer()
        buildBackButton()
        buildModeLabel(text: "numerical")
        buildMessageLabel()
    }
    
    private func buildTimer() {

        let sceneFrame = scene!.frame
        let spotWidth = sceneFrame.width * 0.2859

        let texture = SKTexture(imageNamed: "spot")
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
    
    func buildModeLabel(text: String) {
        
        let sceneFrame = scene!.frame
        modeLabel.fontSize = sceneFrame.width * 0.08
        modeLabel.position = CGPoint(x: 0.9 * sceneFrame.midX, y: size.height * 0.915)
        modeLabel.fontColor = UIColor(red: 0, green: 162.0/255, blue: 1, alpha: 1.0)
        modeLabel.text = "Mode: \(text)"
    
        addChild(modeLabel)
    }
    
    private func buildMessageLabel() {
        
        let sceneFrame = scene!.frame
        messageLabel.fontSize = sceneFrame.width * 0.11
        messageLabel.position = CGPoint(x: sceneFrame.midX, y: modeLabel.position.y - sceneFrame.height * 0.1)
        messageLabel.fontColor = UIColor(red: 97.0/255, green: 216.0/255, blue: 54.0/255, alpha: 1.0)
        
        addChild(messageLabel)
    }
}
