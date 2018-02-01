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
    
    private let splashActionKey = "splash_action"
    
    private let maxSplashes: Int
    private let spotFormats: [SKSpriteNode]
    
    private var splashes: [SKSpriteNode]
    
    public var isSplashingAutomatically: Bool {
        return self.action(forKey: splashActionKey) != nil
    }
    
    //MARK: Initializers
    
    init(size: CGSize) {
        
        self.maxSplashes = 25
        self.spotFormats = [1, 2, 3, 4, 5, 6].map {
            let name = String.init(format: "splash_%0.3d", $0)
            return SKSpriteNode(imageNamed: name)
        }
        self.splashes = []
        
        super.init(texture: nil, color: .clear, size: size)
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Main methods
    
    public func splashAutomatically(withInterval interval: TimeInterval) {
        
        let splashAction = SKAction.run {
            self.splash(atPosition: self.randomPosition())
        }
        let waitAction = SKAction.wait(forDuration: interval)
        let autoSplashAction = SKAction.sequence([waitAction, splashAction])
        
        self.run(SKAction.repeatForever(autoSplashAction), withKey: self.splashActionKey)
    }
    
    public func stopSplashingAutomatically() {
        self.removeAction(forKey: self.splashActionKey)
    }
    
    private func splash(atPosition position: CGPoint) {
        
        guard let scene = self.scene else { return }
        
        while self.splashes.count >= self.maxSplashes {
            
            self.removeSplash(self.splashes.first!)
            self.splashes.removeFirst()
        }
        
        let spot = randomSpot()
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 1.7 : 2.2
        
        let ratio = spot.size.width / spot.size.height
        let width = scene.size.width / factor
        
        spot.size = CGSize(width: width, height: width / ratio)
        spot.zRotation = CGFloat(Double.pi * Double(Int(arc4random()) % 60) / 60.0)
        spot.position = position
        spot.isUserInteractionEnabled = false
        spot.colorBlendFactor = 0.1
        
        self.addChild(spot)
        self.splashes.append(spot)
    }
    
    private func removeSplash(_ splash: SKSpriteNode) {
        
        let fadeAction = SKAction.fadeOut(withDuration: 5.0)
        let removeAction = SKAction.removeFromParent()
        let action = SKAction.sequence([fadeAction, removeAction])
        
        splash.run(action)
    }
    
    //MARK: Helper methods
    
    private func randomSpot() -> SKSpriteNode {
        
        let random = Int(arc4random_uniform(UInt32(self.spotFormats.count)))
        return self.spotFormats[random].copy() as! SKSpriteNode
    }
    
    private func randomPosition() -> CGPoint {
        
        let x = CGFloat(arc4random_uniform(UInt32(self.size.width))) - self.size.width / 2
        let y = CGFloat(arc4random_uniform(UInt32(self.size.height))) - self.size.height / 2
        
        return CGPoint(x: x, y: y)
    }
    
    //MARK: Touch methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        guard let scene = self.scene else { return }
        
        let position = touch.location(in: self)
        let p = touch.location(in: scene)
        
        if  p.x >= self.frame.minX && p.x <= self.frame.maxX &&
            p.y >= self.frame.minY && p.y <= self.frame.maxY {
            self.splash(atPosition: position)
        }
    }
}
