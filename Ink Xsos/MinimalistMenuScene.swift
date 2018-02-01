//
//  MinimalistMenuScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 27/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class MinimalistMenuScene: SKScene {

    var gameName: SKSpriteNode!
    var paintNode: PaintNode!
    
    var randomGameButton: Button!
    var selectModeButton: Button!
    var configurationsButton: Button!
    var moreGamesButton: Button!
    
    var soundController: SoundController?
    
    var menuButtonSize: CGSize {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.3 : 0.2
        
        let proportion = CGFloat(300.0) / 300.0
        let width = self.size.width * factor
        let height = width * proportion
        
        return CGSize(width: width, height: height)
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        self.backgroundColor = .white
        self.setup()
    }
    
    private func setup() {
        
        self.setupGameName()
        self.setupButtons()
        self.setupPaintNode()
    }
    
    private func setupGameName() {
        
        self.gameName = SKSpriteNode(imageNamed: Images.gameName)
        self.gameName.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.gameName.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.95)
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.85 : 0.6
        
        let ratio = self.gameName.size.width / self.gameName.size.height
        let width = self.size.width * factor
        self.gameName.size = CGSize(width: width, height: width / ratio)
        
        self.addChild(self.gameName)
    }
    
    private func setupButtons() {
        
        let buttonWidth = self.scene!.frame.width * 0.3
        let paletteLeft = CGFloat(0.0)
        let paletteRight = self.scene!.frame.width
        let paletteMidHeight = self.scene!.frame.height * 0.18
        
        let left = paletteLeft + buttonWidth / 2
        let right = paletteRight - buttonWidth / 2
        let xSpacing = (right - left) / 3.0
        
        let xPositions = (0...3).map { position in left + xSpacing * CGFloat(position) }
        let yPositions = [1.5, 1, 1, 1.5].map { multiplier in paletteMidHeight * multiplier }
        
        let buttonPositions = (0...3).map { index in CGPoint(x: xPositions[index], y: yPositions[index]) }
        
        self.setupSelectModeButton(atPosition: buttonPositions[1])
        self.setupConfigurationsButton(atPosition: buttonPositions[2])
    }
    
    private func setupPaintNode() {
        
        let width = self.size.width
        let height = self.gameName.position.y - self.gameName.size.height * 1.5// -
//                     (self.selectModeButton.position.y +
//                      self.selectModeButton.size.height / 2)
        let paintSize = CGSize(width: width, height: height)
        
        self.paintNode = PaintNode(size: paintSize)
        self.paintNode.zPosition = -1
        self.paintNode.position = CGPoint(x: self.frame.midX, y: /*self.selectModeButton.position.y + self.selectModeButton.size.height / 2 +*/ height / 2)
        
        self.paintNode.splashAutomatically(withInterval: 3)
        
        self.addChild(paintNode)
    }
    
    private func setupRandomGameButton(atPosition position: CGPoint) {
        
        self.randomGameButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.randomGame)) { _ in
            self.switchToScene(ClassicScene.self)
        }
        //self.randomGameButton.size = self.menuButtonSize
        self.randomGameButton.position = position
        self.randomGameButton.zPosition = 1
        
        addChild(self.randomGameButton)
    }
    
    private func setupSelectModeButton(atPosition position: CGPoint) {
        
        self.selectModeButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.play)) { _ in
            self.soundController?.stopSound()
            
            guard let view = self.view else { return }
            
            let sceneInstance = ClassicScene2(size: view.bounds.size)
            //sceneInstance.soundController = self.soundController
            let transition = SKTransition.fade(with: .white, duration: 1.0)
            view.presentScene(sceneInstance, transition: transition)
        }
        
        self.selectModeButton.size = self.menuButtonSize
        self.selectModeButton.position = position
        self.selectModeButton.zPosition = 1
        
        addChild(self.selectModeButton)
    }
    
    private func setupConfigurationsButton(atPosition position: CGPoint) {
        
        self.configurationsButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.configurations)) { _ in
            guard let view = self.view else { return }
            
            let sceneInstance = SettingsScene(size: view.bounds.size)
            sceneInstance.soundController = self.soundController
            let transition = SKTransition.fade(with: .white, duration: 1.0)
            view.presentScene(sceneInstance, transition: transition)
        }
        self.configurationsButton.size = self.menuButtonSize
        self.configurationsButton.position = position
        self.configurationsButton.zPosition = 1
        
        addChild(self.configurationsButton)
    }
    
    private func setupMoreGamesButton(atPosition position: CGPoint) {
        
        self.moreGamesButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.moreGames)) { _ in
            print("More games")
        }
        //self.moreGamesButton.size = self.menuButtonSize
        self.moreGamesButton.position = position
        self.moreGamesButton.zPosition = 1
        
        addChild(self.moreGamesButton)
    }
}
