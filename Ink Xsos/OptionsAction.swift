//
//  OptionsAction.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 17/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class OptionsAction: NSObject {

    var scene: SKScene
    var uiElements = [SKNode]()
    let blankZPos: CGFloat = 20
    var defaultPos: CGPoint {
        return CGPoint(x: sceneFrame.width * 0.13, y: sceneFrame.height * 0.93)
    }
    var sceneFrame: CGRect { return scene.frame }

    init(scene: SKScene) { self.scene = scene }
    
    func addOptionsButton(atPosition pos: CGPoint? = nil) {
        
        let optionsButton = OptionsButton(sceneSize: self.scene.size)
        if let Pos = pos { optionsButton.position = Pos }
        else { optionsButton.position = defaultPos }
        
        optionsButton.action = self
        scene.addChild(optionsButton)
    }
    
    func setBackground() {

        let blank = SKSpriteNode(texture: SKTexture(imageNamed: "blank"), color: .clear, size: scene.size)
        blank.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        blank.zPosition = blankZPos
        blank.alpha = 0.9
        
        let splashTexture = SKTexture(imageNamed: Images.Spots.option_splash)
        let splashProportion = splashTexture.size().height / splashTexture.size().width
        let splashSize = CGSize(width: sceneFrame.width, height: sceneFrame.width * splashProportion)
        let splash = SKSpriteNode(texture: splashTexture, color: .clear, size: splashSize)
        splash.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height - splashSize.height / 2)
        splash.zPosition = blank.zPosition + 1
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.18 : 0.14
        
        let optionsLabel = SKLabelNode(text: "options")
        optionsLabel.fontSize = sceneFrame.width * factor
        optionsLabel.position = CGPoint(x: sceneFrame.midX, y: sceneFrame.height * 0.915)
        optionsLabel.fontColor = .white
        optionsLabel.zPosition = splash.zPosition + 1
        optionsLabel.fontName = Fonts.ink
        
        scene.addChild(blank)
        scene.addChild(splash)
        scene.addChild(optionsLabel)
        
        uiElements.append(blank)
        uiElements.append(splash)
        uiElements.append(optionsLabel)
    }
    
    func setSoundButton() {
        
        let soundButtonTexture = SKTexture(imageNamed: "\(Images.Buttons.sound)_001")
        let soundButtonProportion = soundButtonTexture.size().height / soundButtonTexture.size().width
        let soundButtonWidth = sceneFrame.width * 0.55
        let soundButtonSize = CGSize(width: soundButtonWidth, height: soundButtonWidth * soundButtonProportion)
        let soundButtonSprite = SKSpriteNode(texture: soundButtonTexture, color: .clear, size: soundButtonSize)
        let soundButton = CustomButton(sprite: soundButtonSprite)
        soundButton.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.65)
        soundButton.zPosition = blankZPos + 1
        let optionSound = OptionsUtil(type: .set_sound, view: scene.view!)
        optionSound.soundDelegate = self
        soundButton.action = optionSound
        soundButton.name = "SoundButton"
        
        if defaultsStandard.soundOn() {
            let number = soundButtonSprite.numberOfFrames(forImageNamed: Images.Buttons.sound)
            let name = String.init(format: "\(Images.Buttons.sound)_%03d", number)
            soundButton.imageButton.texture = SKTexture(imageNamed: name)
        }
        soundButton.action = optionSound
        
        scene.addChild(soundButton)
        uiElements.append(soundButton)
    }
    
    func setBackButton(imageName: String, pos: CGPoint, text: String, type: TypeOfButton) {
        
        let backButtonTexture = SKTexture(imageNamed: imageName)
        let backButtonProportion = backButtonTexture.size().height / backButtonTexture.size().width
        let backButtonWidth = sceneFrame.width * 0.75
        let backButtonSize = CGSize(width: backButtonWidth, height: backButtonWidth * backButtonProportion)
        let backButtonSprite = SKSpriteNode(texture: backButtonTexture, color: .clear, size: backButtonSize)
        let backButton = CustomButton(sprite: backButtonSprite)
        backButton.position = pos
        let optionBack = OptionsUtil(type: type, view: scene.view!)
        backButton.action = optionBack
        if type == .hide_options { optionBack.hideDelegate = self }
        backButton.zPosition = blankZPos + 1
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.18 : 0.14
        
        let backLabel = SKLabelNode(text: text)
        backLabel.fontSize = sceneFrame.width * factor * 0.45
        backLabel.position = CGPoint(x: 0, y: backButtonSize.height * -0.05)
        backLabel.fontColor = .white
        backLabel.zPosition = backButton.zPosition + 1
        backLabel.fontName = Fonts.ink
        backButton.touchableArea.addChild(backLabel)
        
        scene.addChild(backButton)
        uiElements.append(backButton)
    }
}

extension OptionsAction: ButtonAction {
    
    func execute() {
        
        let hideOptionsPos = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.4)
        let backToMenuPos = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.15)
        
        setBackground()
        setSoundButton()
        setBackButton(imageName: Images.Buttons.backGame,
                      pos: hideOptionsPos,
                      text: "hide options",
                      type: .hide_options)
        setBackButton(imageName: Images.Buttons.backMenu,
                      pos: backToMenuPos,
                      text: "back to menu",
                      type: .back_to_menu)
    }
}

extension OptionsAction: HideOptionsDelegate {
    
    func hide() {
        
        for element in uiElements { element.removeFromParent() }
        uiElements.removeAll()
    }
}

extension OptionsAction: TouchSoundDelegate {
    
    func animateButton() {
        
        let isSoundOn = defaultsStandard.soundOn()
        let btns = uiElements.filter { (node) -> Bool in
            node.name == "SoundButton"
        }
        let soundBtn: CustomButton = btns[0] as! CustomButton
        var animationAction: SKAction
        if isSoundOn {
            animationAction = soundBtn.imageButton.animation(atlasName: Images.Buttons.sound,
                                                             duration: 0.3)
        } else {
            animationAction = soundBtn.imageButton.animation(atlasName: Images.Buttons.sound,
                                                             duration: 0.3, backward: true)
        }
        soundBtn.imageButton.run(animationAction)
    }
}
