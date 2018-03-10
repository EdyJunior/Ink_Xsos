//
//  SelectAdversaryScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 05/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class SelectAdversaryScene: SKScene {
    
    var humanButton: CustomButton!
    var aiButton: CustomButton!
    
    var buttonSize: CGSize {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.3125 : 0.15
        
        let proportion: CGFloat = 940.0 / 620
        let width = self.size.width * factor
        let height = width * proportion
        
        return CGSize(width: width, height: height)
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        self.buildScene()
    }
    
    func buildScene() {
        
        self.backgroundColor = .white
        buildLabels()
        setupHumanButton()
        setupAIButton()
        buildBackground()
    }
    
    func buildLabels() {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.12 : 0.08
        let sceneFrame = scene!.frame
        
        let adversaryLabel = SKLabelNode(fontNamed: Fonts.ink)
        adversaryLabel.text = "adversary"
        adversaryLabel.fontSize = sceneFrame.width * factor
        adversaryLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.915)
        adversaryLabel.fontColor = Colors.blue
        addChild(adversaryLabel)
        
        let humanLabel = SKLabelNode(fontNamed: Fonts.ink)
        humanLabel.text = "human"
        humanLabel.fontSize = sceneFrame.width * factor
        humanLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.81)
        humanLabel.fontColor = Colors.green
        addChild(humanLabel)
        
        let aiLabel = SKLabelNode(fontNamed: Fonts.ink)
        aiLabel.text = "robot"
        aiLabel.fontSize = sceneFrame.width * factor
        aiLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.38)
        aiLabel.fontColor = Colors.red
        addChild(aiLabel)
    }
    
    private func setupHumanButton() {
        
        let sprite = SKSpriteNode(imageNamed: Images.Buttons.human)
        sprite.size = buttonSize
        self.humanButton = CustomButton(sprite: sprite)
        self.humanButton.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height * 0.65)
        self.humanButton.zPosition = 1
        self.humanButton.noDelegateAction = humanAction
        
        addChild(self.humanButton)
    }
    
    private func setupAIButton() {
        
        let sprite = SKSpriteNode(imageNamed: Images.Buttons.robot)
        sprite.size = buttonSize
        self.aiButton = CustomButton(sprite: sprite)
        self.aiButton.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height * 0.225)
        self.aiButton.zPosition = 1
        self.aiButton.noDelegateAction = aiAction
        
        addChild(self.aiButton)
    }
    
    func humanAction() {
        
        guard let view = self.view else { return }
        
        let sceneInstance = ClassicScene(size: view.bounds.size)
        sceneInstance.hasAI = false
        let transition = SKTransition.fade(with: .white, duration: 1.0)
        view.presentScene(sceneInstance, transition: transition)
    }
    
    func aiAction() {
        
        guard let view = self.view else { return }
        
        let sceneInstance = ClassicScene(size: view.bounds.size)
        sceneInstance.hasAI = true
        let transition = SKTransition.fade(with: .white, duration: 1.0)
        view.presentScene(sceneInstance, transition: transition)
    }
    
    private func buildBackground() {
        
        let w = scene!.frame.width
        let h = scene!.frame.height
        let texture1 = SKTexture(imageNamed: "splash_004")
        let texture2 = SKTexture(imageNamed: "splash_001")
        let texture3 = SKTexture(imageNamed: "splash_005")
        let texture4 = SKTexture(imageNamed: "splash_006")
        let position1 = CGPoint(x: w * 1.05, y: h * 0.93)
        let position2 = CGPoint(x: -w * 0.11, y: h * 0.67)
        let position3 = CGPoint(x: w * 1.05, y: h * 0.2)
        let position4 = CGPoint(x: -w * 0.06, y: h * 0.15)
        let proportion = texture1.size().height / texture1.size().width
        let splashesSize = CGSize(width: w * 0.85, height: w * 0.85 * proportion)
        
        let splash1 = SKSpriteNode(texture: texture1, color: .clear, size: splashesSize)
        let splash2 = SKSpriteNode(texture: texture2, color: .clear, size: splashesSize)
        let splash3 = SKSpriteNode(texture: texture3, color: .clear, size: splashesSize)
        let splash4 = SKSpriteNode(texture: texture4, color: .clear, size: splashesSize)
        splash1.position = position1
        splash2.position = position2
        splash3.position = position3
        splash4.position = position4
        splash1.zPosition = -1
        splash2.zPosition = -1
        splash3.zPosition = -1
        splash4.zPosition = -1
        splash1.alpha = 0
        splash2.alpha = 0
        splash3.alpha = 0
        splash4.alpha = 0
        
        addChild(splash1)
        addChild(splash2)
        addChild(splash3)
        addChild(splash4)
        
        let wait = SKAction.wait(forDuration: 0.2)
        let fade = SKAction.fadeAlpha(to: 1.0, duration: 0.25)
        let act1 = SKAction.run { splash4.run(fade) }
        let act2 = SKAction.run { splash1.run(fade) }
        let act3 = SKAction.run { splash3.run(fade) }
        let act4 = SKAction.run { splash2.run(fade) }
        let act = SKAction.sequence([act1, wait, act2, wait, act3, wait, act4])
        scene?.run(act)
    }
}
