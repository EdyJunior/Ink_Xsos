//
//  MenuScene.swift
//  Ink Xsos
//
//  Created by Vítor Chagas on 14/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var gameLabel: SKLabelNode!
    var randomGameButton: Button!
    var selectModeButton: Button!
    var configurationsButton: Button!
    var moreGamesButton: Button!
    
    var paintPalette: SKSpriteNode!
    
    var menuButtonSize: CGSize {
        
        let width = self.size.width * 0.45
        let height = width * 0.75
        
        return CGSize(width: width, height: height)
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        self.setup()
    }
    
    private func setup() {
        
        self.setupGameLabel()
        //self.setupButtons()
        self.setupPaintPalette()
    }
    
    private func setupGameLabel() {
        
        self.gameLabel = SKLabelNode(text: "Ink XsOs")
        self.gameLabel.fontColor = .black
        self.gameLabel.fontSize = 60
        
        self.gameLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - self.gameLabel.frame.height * 1.75)
        
        self.addChild(self.gameLabel)
    }
    
    private func setupPaintPalette() {
        
        self.paintPalette = SKSpriteNode(imageNamed: "paint_palette")
        
        self.paintPalette.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.paintPalette.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        
        let proportion = self.paintPalette.size.width / self.paintPalette.size.height
        self.paintPalette.size = CGSize(width: self.size.width, height: self.size.width / proportion)
        
        self.addChild(self.paintPalette)
    }
    
    private func setupButtons() {
        
        let width = self.menuButtonSize.width
        let height = self.menuButtonSize.height
        
        let midHeight = self.frame.midY
        let widthOffset = (self.size.width - 2 * width) / 3
        
        let left = widthOffset + width / 2
        let right = 2 * widthOffset + 3 * width / 2
        let top = midHeight
        let bottom = midHeight - height - widthOffset
        
        let buttonPositions = [
            CGPoint(x: left,  y: top),    // top left
            CGPoint(x: right, y: top),    // top right
            CGPoint(x: left,  y: bottom), // bottom left
            CGPoint(x: right, y: bottom)  // bottom right
        ]
        
        self.setupRandomGameButton(atPosition: buttonPositions[0])
        self.setupSelectModeButton(atPosition: buttonPositions[1])
        self.setupConfigurationsButton(atPosition: buttonPositions[2])
        self.setupMoreGamesButton(atPosition: buttonPositions[3])
    }
    
    private func setupRandomGameButton(atPosition position: CGPoint) {
        
        let sprite = SKSpriteNode(color: .red, size: self.menuButtonSize)
        
        self.randomGameButton = Button(sprite: sprite) { _ in
            print("Random game")
            
            guard let view = self.view else { return }
            
            let classicScene = ClassicScene(size: view.bounds.size)
            view.presentScene(classicScene)
        }
        self.randomGameButton.position = position
        
        self.addChild(self.randomGameButton)
    }
    
    private func setupSelectModeButton(atPosition position: CGPoint) {
        
        let sprite = SKSpriteNode(color: .blue, size: self.menuButtonSize)
        
        self.selectModeButton = Button(sprite: sprite) { _ in print("Select mode") }
        self.selectModeButton.position = position
        
        self.addChild(self.selectModeButton)
    }
    
    private func setupConfigurationsButton(atPosition position: CGPoint) {
        
        let sprite = SKSpriteNode(color: .green, size: self.menuButtonSize)
        
        self.configurationsButton = Button(sprite: sprite) { _ in print("Configurations") }
        self.configurationsButton.position = position
        
        self.addChild(self.configurationsButton)
    }
    
    private func setupMoreGamesButton(atPosition position: CGPoint) {
        
        let sprite = SKSpriteNode(color: .black, size: self.menuButtonSize)
        
        self.moreGamesButton = Button(sprite: sprite) { _ in print("More games") }
        self.moreGamesButton.position = position
        
        self.addChild(self.moreGamesButton)
    }
    
}




