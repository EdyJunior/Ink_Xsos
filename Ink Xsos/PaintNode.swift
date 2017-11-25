//
//  PaintNode.swift
//  Ink Xsos
//
//  Created by Vítor Chagas on 24/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class PaintNode: SKSpriteNode {

    //MARK: Properties
    
    private let maxSplashes: Int
    private let spotFormats: [SKSpriteNode]
    private let spotColors: [UIColor]
    
    private var splashes: [SKSpriteNode]
    
    //MARK: Initializers
    
    init(size: CGSize) {
        
        self.maxSplashes = 25
        self.spotFormats = [0,5].map { SKSpriteNode(imageNamed: "white_spot_\($0)") }
        self.spotColors = [.red, .green, .blue, .yellow, .cyan, .orange, .purple]
        
        self.splashes = []
        
        super.init(texture: nil, color: .clear, size: size)
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Main methods
    
    private func splash(atPosition position: CGPoint) {
        
        guard let scene = self.scene else { return }
        
        let spot = randomSpot()
        
        let ratio = spot.size.width / spot.size.height
        let width = scene.size.width / 1.5
        
        spot.size = CGSize(width: width, height: width / ratio)
        spot.zRotation = CGFloat(Double.pi * Double(Int(arc4random()) % 60) / 60.0)
        spot.position = position
        spot.blendMode = .subtract
        
        let colorizeAction = SKAction.colorize(with: randomColor(), colorBlendFactor: 0.75, duration: 0.1)
        
        spot.run(colorizeAction)
        self.addChild(spot)
    }
    
    //MARK: Helper methods
    
    private func randomSpot() -> SKSpriteNode {
        
        let random = Int(arc4random_uniform(UInt32(self.spotFormats.count)))
        return self.spotFormats[random].copy() as! SKSpriteNode
    }
    
    private func randomColor() -> UIColor {
        
        let random = Int(arc4random_uniform(UInt32(self.spotColors.count)))
        return self.spotColors[random]
    }
    
    //MARK: Touch methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        self.splash(atPosition: touch.location(in: self))
    }
    
}
