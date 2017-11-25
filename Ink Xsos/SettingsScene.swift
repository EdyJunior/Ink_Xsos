//
//  ConfigurationScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 24/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class SettingsScene: SKScene {

    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        self.backgroundColor = .white
        buildScene()
    }
    
    func buildScene() {
        
        buildBackButton()
        buildLabels()
        buildButtons()
    }
    
    private func buildBackButton() {
        
        let backButton = Button(defaultButtonImage: Images.arrow, activeButtonImage: Images.arrow) { _ in
            self.switchToScene(MenuScene.self)
        }
        
        backButton.size = CGSize(width: size.width * 0.12, height: size.width * 0.12)
        backButton.position = CGPoint(x: size.width * 0.08, y: size.height * 0.93)
        
        backButton.touchableArea.zPosition = 1
        backButton.touchableArea.xScale *= -1
        
        addChild(backButton)
    }
    
    func buildLabels() {
        
        let sceneFrame = scene!.frame
        
        let settingsLabel = SKLabelNode(fontNamed: Fonts.ink)
        settingsLabel.text = "settings"
        settingsLabel.fontSize = sceneFrame.width * 0.1
        settingsLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.915)
        settingsLabel.fontColor = UIColor(red: 0, green: 162.0/255, blue: 1, alpha: 1.0)
        addChild(settingsLabel)
        
        let soundLabel = SKLabelNode(fontNamed: Fonts.ink)
        soundLabel.text = "sound"
        soundLabel.fontSize = sceneFrame.width * 0.07
        soundLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.8)
        soundLabel.fontColor = .red
        addChild(soundLabel)
        
        let animationsLabel = SKLabelNode(fontNamed: Fonts.ink)
        animationsLabel.text = "animations"
        animationsLabel.fontSize = sceneFrame.width * 0.07
        animationsLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.415)
        animationsLabel.fontColor = .green
        addChild(animationsLabel)
    }
    
    func buildButtons() {
        
    }
    
    func touchSound(_ button: Button) {
        
    }
    
    func touchAnimation(_ button: Button) {
        
    }
}
