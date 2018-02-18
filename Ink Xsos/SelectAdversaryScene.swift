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
        let factor: CGFloat = device == .phone ? 0.5 : 0.35
        
        let proportion = CGFloat(1)
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
        setupOptionsButton()
        buildLabels()
        setupHumanButton()
        setupAIButton()
    }
    
    func setupOptionsButton() {
        
        let optionsAction = OptionsAction(scene: scene!)
        optionsAction.addOptionsButton()
    }
    
    func buildLabels() {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.1 : 0.08
        let sceneFrame = scene!.frame
        
        let adversaryLabel = SKLabelNode(fontNamed: Fonts.ink)
        adversaryLabel.text = "Adversary"
        adversaryLabel.fontSize = sceneFrame.width * factor
        adversaryLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.915)
        adversaryLabel.fontColor = UIColor(red: 0, green: 162.0/255, blue: 1, alpha: 1.0)
        addChild(adversaryLabel)
        
        let humanLabel = SKLabelNode(fontNamed: Fonts.ink)
        humanLabel.text = "Human"
        humanLabel.fontSize = sceneFrame.width * factor
        humanLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.55)
        humanLabel.fontColor = .red
        addChild(humanLabel)
        
        let aiLabel = SKLabelNode(fontNamed: Fonts.ink)
        aiLabel.text = "Robot"
        aiLabel.fontSize = sceneFrame.width * factor
        aiLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.15)
        aiLabel.fontColor = .red
        addChild(aiLabel)
    }
    
    private func setupHumanButton() {
        
        let sprite = SKSpriteNode(imageNamed: Images.Buttons.play)
        sprite.size = buttonSize
        self.humanButton = CustomButton(sprite: sprite)
        self.humanButton.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height * 0.75)
        self.humanButton.zPosition = 1
        self.humanButton.noDelegateAction = humanAction
        
        addChild(self.humanButton)
    }
    
    private func setupAIButton() {
        
        let sprite = SKSpriteNode(imageNamed: Images.Buttons.configurations)
        sprite.size = buttonSize
        self.aiButton = CustomButton(sprite: sprite)
        self.aiButton.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height * 0.35)
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
}
