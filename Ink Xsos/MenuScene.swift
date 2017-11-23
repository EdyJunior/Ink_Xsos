//
//  MenuScene.swift
//  Ink Xsos
//
//  Created by Vítor Chagas on 14/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var gameName: SKSpriteNode!
    var paintPalette: SKSpriteNode!
    
    var randomGameButton: Button!
    var selectModeButton: Button!
    var configurationsButton: Button!
    var moreGamesButton: Button!
    
    var menuButtonSize: CGSize {
        
        let width = self.size.width * 0.25
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
        self.setupPaintPalette()
        self.setupButtons()
    }
    
    private func setupGameName() {
        
        self.gameName = SKSpriteNode(imageNamed: Images.gameName)
        self.gameName.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.gameName.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.95)
        
        let ratio = self.gameName.size.width / self.gameName.size.height
        let width = self.size.width * 0.8
        self.gameName.size = CGSize(width: width, height: width / ratio)
        
        self.addChild(self.gameName)
    }
    
    private func setupPaintPalette() {
        
        self.paintPalette = SKSpriteNode(imageNamed: Images.paintPallete)
        
        self.paintPalette.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.paintPalette.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        
        let proportion = self.paintPalette.size.width / self.paintPalette.size.height
        self.paintPalette.size = CGSize(width: self.size.width, height: self.size.width / proportion)
        
        self.addChild(self.paintPalette)
    }
    
    private func setupButtons() {
        
        let buttonWidth = self.menuButtonSize.width
        let paletteLeft = -self.paintPalette.size.width / 2
        let paletteRight = -paletteLeft
        let paletteMidHeight = self.paintPalette.frame.midY
        
        let left = paletteLeft + buttonWidth / 2
        let right = paletteRight - buttonWidth / 2
        let xSpacing = (right - left) / 3.0
        
        let xPositions = (0...3).map { position in left + xSpacing * CGFloat(position) }
        let yPositions = [0.9, 0.6, 0.6, 0.9].map { multiplier in paletteMidHeight * multiplier }
        
        let buttonPositions = (0...3).map { index in CGPoint(x: xPositions[index], y: yPositions[index]) }
        
        //self.setupRandomGameButton(atPosition: buttonPositions[0])
        self.setupSelectModeButton(atPosition: buttonPositions[1])
        self.setupConfigurationsButton(atPosition: buttonPositions[2])
        //self.setupMoreGamesButton(atPosition: buttonPositions[3])
    }
    
    private func setupRandomGameButton(atPosition position: CGPoint) {
        
        self.randomGameButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.randomGame)) { _ in
            self.switchToScene(ClassicScene.self)
        }
        self.randomGameButton.size = self.menuButtonSize
        self.randomGameButton.position = position
        self.randomGameButton.zPosition = 1
        
        self.paintPalette.addChild(self.randomGameButton)
    }
    
    private func setupSelectModeButton(atPosition position: CGPoint) {
        
        self.selectModeButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.play)) { _ in
            self.switchToScene(ClassicScene.self)
        }
        self.selectModeButton.size = self.menuButtonSize
        self.selectModeButton.position = position
        self.selectModeButton.zPosition = 1
        
        self.paintPalette.addChild(self.selectModeButton)
    }
    
    private func setupConfigurationsButton(atPosition position: CGPoint) {
        
        self.configurationsButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.configurations)) { _ in
            print("Configurations")
        }
        self.configurationsButton.size = self.menuButtonSize
        self.configurationsButton.position = position
        self.configurationsButton.zPosition = 1
        
        self.paintPalette.addChild(self.configurationsButton)
    }
    
    private func setupMoreGamesButton(atPosition position: CGPoint) {
        
        self.moreGamesButton = Button(sprite: SKSpriteNode(imageNamed: Images.Buttons.moreGames)) { _ in
            print("More games")
        }
        self.moreGamesButton.size = self.menuButtonSize
        self.moreGamesButton.position = position
        self.moreGamesButton.zPosition = 1
        
        self.paintPalette.addChild(self.moreGamesButton)
    }
    
}
