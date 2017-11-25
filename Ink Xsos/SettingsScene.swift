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
        animationsLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.4)
        animationsLabel.fontColor = .green
        addChild(animationsLabel)
    }
    
    func buildButtons() {
        
        let sceneFrame = self.scene!.frame
        let buttonSize = CGSize(width: sceneFrame.width * 0.5, height: sceneFrame.width * 0.5)
        
        let soundButtonPosition = CGPoint(x: sceneFrame.midX, y: size.height * 0.65)
        var soundDefault = "soundOn", soundActive = "soundOff"
        if let soundOn = defaults.value(forKey: Defaults.soundOn) as? Bool {
            if !soundOn {
                soundDefault = "soundOff"
                soundActive = "soundOn"
            }
        } else { defaults.set(true, forKey: Defaults.soundOn) }
        let soundButton = Button(defaultButtonImage: soundDefault, activeButtonImage: soundActive, buttonAction: touchSound)
        soundButton.size = buttonSize
        soundButton.position = soundButtonPosition
        addChild(soundButton)
        
        let animationsButtonPosition = CGPoint(x: sceneFrame.midX, y: size.height * 0.25)
        var animationsDefault = "yes", animationsActive = "no"
        if let animationsOn = defaults.value(forKey: Defaults.animationsOn) as? Bool {
            if !animationsOn {
                animationsDefault = "no"
                animationsActive = "yes"
            }
        } else { defaults.set(true, forKey: Defaults.animationsOn) }
        let animationsButton = Button(defaultButtonImage: animationsDefault, activeButtonImage: animationsActive, buttonAction: touchAnimation)
        animationsButton.size = buttonSize
        animationsButton.position = animationsButtonPosition
        addChild(animationsButton)
    }
    
    func touchSound(_ button: Button) {
        
        print("switch sound")
    }
    
    func touchAnimation(_ button: Button) {
        
        print("switch animations")
    }
}
