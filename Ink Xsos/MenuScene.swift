//
//  MenuScene.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 27/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var gameName: SKSpriteNode!
    var paintNode: PaintNode!
    
    var selectModeButton: Button!
    var moreGamesButton: Button!
    
    var soundController: SoundController?
    
    var menuButtonSize: CGSize {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.35 : 0.3
        
        let width = self.size.width * factor
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        self.backgroundColor = .white
        self.setup()
    }
    
    private func setup() {
        
        self.setupGameName()
        self.setupButton()
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
    
    private func setupButton() {

        self.selectModeButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.play)) { _ in
            self.soundController?.stopSound()
            
            guard let view = self.view else { return }
            
            let sceneInstance = SelectAdversaryScene(size: view.bounds.size)
            //sceneInstance.soundController = self.soundController
            let transition = SKTransition.fade(with: .white, duration: 1.0)
            view.presentScene(sceneInstance, transition: transition)
        }
        self.selectModeButton.size = self.menuButtonSize
        let xButton = scene!.size.width / 2
        let yButton = self.scene!.frame.height * 0.18
        self.selectModeButton.position = CGPoint(x: xButton, y: yButton)
        self.selectModeButton.zPosition = 1
        
        addChild(self.selectModeButton)
    }
    
    private func setupPaintNode() {
        
        let width = self.size.width
        let height = self.gameName.position.y - self.gameName.size.height * 1.5
        let paintSize = CGSize(width: width, height: height)
        
        self.paintNode = PaintNode(size: paintSize)
        self.paintNode.zPosition = -1
        self.paintNode.position = CGPoint(x: self.frame.midX, y: height / 2)
        
        self.paintNode.splashAutomatically(withInterval: 3)
        
        self.addChild(paintNode)
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

