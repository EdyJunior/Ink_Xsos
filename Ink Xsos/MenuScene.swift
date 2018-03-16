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
    
    var playButton: CustomButton!
    var moreGamesButton: CustomButton!
    
    var soundController: SoundController?
    
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

        let playButtonTexture = SKTexture(imageNamed: Images.Buttons.play)
        let playButtonProportion = playButtonTexture.size().height / playButtonTexture.size().width
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.35 : 0.23
        
        let playButtonWidth = scene!.frame.width * factor
        let playButtonSize = CGSize(width: playButtonWidth, height: playButtonWidth * playButtonProportion)
        let playButtonSprite = SKSpriteNode(texture: playButtonTexture, color: .clear, size: playButtonSize)
        playButton = CustomButton(sprite: playButtonSprite)
        let xButton = scene!.size.width / 2
        let yButton = self.scene!.frame.height * 0.18
        playButton.position = CGPoint(x: xButton, y: yButton)
        playButton.zPosition = 1
        playButton.noDelegateAction = playAction
        
        addChild(self.playButton)
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
        
        self.moreGamesButton = CustomButton(sprite: SKSpriteNode(imageNamed: Images.Buttons.moreGames))
        self.moreGamesButton.position = position
        self.moreGamesButton.zPosition = 1
        
        addChild(self.moreGamesButton)
    }
    
    func playAction() {
        
        self.soundController?.stopSound()
        guard let view = self.view else { return }
        
        let sceneInstance = SelectAdversaryScene(size: view.bounds.size)
        //sceneInstance.soundController = self.soundController
        let transition = SKTransition.fade(with: .white, duration: 1.0)
        view.presentScene(sceneInstance, transition: transition)
    }
}
