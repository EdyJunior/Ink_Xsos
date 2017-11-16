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
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        self.setup()
    }
    
    private func setup() {
        
        self.setupGameLabel()
    }
    
    private func setupGameLabel() {
        
        self.gameLabel = SKLabelNode(text: "Ink XsOs")
        self.gameLabel.fontColor = .black
        self.gameLabel.fontSize = 60
        
        self.gameLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - self.gameLabel.frame.height * 1.75)
        
        self.addChild(self.gameLabel)
    }
    
}
