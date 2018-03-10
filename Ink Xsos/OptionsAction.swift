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
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.12 : 0.1
        
        let optionsLabel = SKLabelNode(text: "options")
        optionsLabel.fontSize = sceneFrame.width * factor
        optionsLabel.position = CGPoint(x: sceneFrame.midX, y: sceneFrame.height * 0.915)
        optionsLabel.fontColor = Colors.blue
        optionsLabel.zPosition = blankZPos + 2
        optionsLabel.fontName = Fonts.ink
        
        let soundLabel = SKLabelNode(text: "sound")
        soundLabel.fontSize = sceneFrame.width * factor * 1.15
        soundLabel.position = CGPoint(x: sceneFrame.midX, y: sceneFrame.height * 0.78)
        soundLabel.fontColor = Colors.green
        soundLabel.zPosition = blankZPos + 2
        soundLabel.fontName = Fonts.ink
        
        scene.addChild(blank)
        scene.addChild(optionsLabel)
        scene.addChild(soundLabel)
        
        uiElements.append(blank)
        uiElements.append(optionsLabel)
        uiElements.append(soundLabel)
        
        addSplashes()
    }
    
    func addSplashes() {
        
        let w = scene.frame.width
        let h = scene.frame.height
        let texture1 = SKTexture(imageNamed: "splash_003")
        let texture2 = SKTexture(imageNamed: "splash_005")
        let texture3 = SKTexture(imageNamed: "splash_002")
        let position1 = CGPoint(x: w * -0.07, y: h * 0.9)
        let position2 = CGPoint(x: w * 1.05, y: h * 0.9)
        let position3 = CGPoint(x: w * 0.5, y: h * -0.02)
        let proportion = texture1.size().height / texture1.size().width
        let splashesSize = CGSize(width: w * 0.7, height: w * 0.7 * proportion)
        
        let splash1 = SKSpriteNode(texture: texture1, color: .clear, size: splashesSize)
        let splash2 = SKSpriteNode(texture: texture2, color: .clear, size: splashesSize)
        let splash3 = SKSpriteNode(texture: texture3, color: .clear, size: splashesSize)
        splash1.position = position1
        splash2.position = position2
        splash3.position = position3
        splash1.zPosition = blankZPos + 1
        splash2.zPosition = blankZPos + 1
        splash3.zPosition = blankZPos + 1
        splash1.alpha = 0
        splash2.alpha = 0
        splash3.alpha = 0
        
        scene.addChild(splash1)
        scene.addChild(splash2)
        scene.addChild(splash3)
        
        uiElements.append(splash1)
        uiElements.append(splash2)
        uiElements.append(splash3)
        
        let wait = SKAction.wait(forDuration: 0.3)
        let fade = SKAction.fadeAlpha(to: 1.0, duration: 0.3)
        let act1 = SKAction.run { splash1.run(fade) }
        let act2 = SKAction.run { splash2.run(fade) }
        let act3 = SKAction.run { splash3.run(fade) }
        let act = SKAction.sequence([act1, wait, act2, wait, act3])
        scene.run(act)
    }
    
    func setSoundButton() {
        
        let soundButtonTexture = SKTexture(imageNamed: "\(Images.Buttons.sound)_001")
        let soundButtonProportion = soundButtonTexture.size().height / soundButtonTexture.size().width
        let soundButtonWidth = sceneFrame.width * 0.5
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
        backLabel.zPosition = backButton.zPosition + 2
        backLabel.fontName = Fonts.ink
        backButton.touchableArea.addChild(backLabel)
        
        scene.addChild(backButton)
        uiElements.append(backButton)
    }
}

extension OptionsAction: ButtonAction {
    
    func execute() {
        
        let hideOptionsPos = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.45)
        let backToMenuPos = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.25)
        
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
