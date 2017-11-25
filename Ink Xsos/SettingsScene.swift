//
//  ConfigurationScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 24/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class ConfigurationScene: SKScene {

    var configLabel = SKLabelNode(fontNamed: Fonts.ink)
    var soundLabel = SKLabelNode(fontNamed: Fonts.ink)
    var animationsLabel = SKLabelNode(fontNamed: Fonts.ink)
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        self.backgroundColor = .white
        buildScene()
    }
    
    func buildScene() {
        
        buildLabels()
        buildButtons()
    }
    
    func buildLabels() {
        
        
    }
    
    func buildButtons() {
        
        let sceneFrame = self.scene!.frame
        let buttonSize = CGSize(width: sceneFrame.width * 0.3, height: sceneFrame.width * 0.3)
        
        var soundDefault = "soundOn", soundActive = "soundOff"
        if let soundOn = UserDefaults.standard.value(forKey: defaults.soundOn) as? Bool {
            if !soundOn {
                soundDefault = "soundOff"
                soundActive = "soundOn"
            }
        } else { UserDefaults.standard.set(true, forKey: defaults.soundOn) }
        
        let soundLabelPos = soundLabel.position
        let soundYAux = sceneFrame.height * 0.1 + buttonSize.height * 0.5
        
        let soundButtonPosition = CGPoint(x: sceneFrame.midX, y: soundLabelPos.y - soundYAux)
        let soundButton = Button(defaultButtonImage: soundDefault, activeButtonImage: soundActive, buttonAction: touchSound)
        soundButton.size = buttonSize
        soundButton.position = soundButtonPosition
        addChild(soundButton)
        
        
//        let animationButtonPosition = CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>)
//        let animationButton = Button(buttonAction: touchAnimation)
//        animationButton.size = buttonSize
//        animationButton.position = animationButtonPosition
//        addChild(animationButton)
    }
    
    func touchSound(_ button: Button) {
        
        
    }
    
    func touchAnimation(_ button: Button) {
        
        
    }
}
