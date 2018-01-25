//
//  ClassicGrid.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 22/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

protocol TouchedGrid {
    func touchIn(_ xPos: Int, _ yPos: Int)
}

class ClassicGrid: SKSpriteNode {
    
    var touchedProtocol: TouchedGrid?
    var isLocked = false
    var symbols = [SKNode]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGSize) {
        
        let texture = SKTexture(imageNamed: "\(Images.grid)_001")
        
        super.init(texture: texture, color: UIColor.clear, size: size)
        isUserInteractionEnabled = true
        anchorPoint = CGPoint.zero
    }
    
    func lock(_ flag: Bool) { isLocked = flag }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if touches.count == 1 && !isLocked {
            let touch = touches.first!
            let pos = touch.location(in: self)

            let xRel = pos.x / size.width
            let yRel = pos.y / size.height
            var xPos = 0, yPos = 2
            var previous = 1
            
            for i in [2, 3] {
                if xRel > CGFloat(previous) / 3 && xRel <= CGFloat(i) / 3 { xPos = i - 1 }
                if yRel > CGFloat(previous) / 3 && yRel <= CGFloat(i) / 3 { yPos = 3 - i }
                previous = i
            }
            self.touchedProtocol?.touchIn(xPos, yPos)
        }
    }
    
    func draw(symbolName name: String, xPos: Int, yPos: Int, animated: Bool) {
        
        let sprite = SKSpriteNode(imageNamed: "\(name)_001")
        let unit = self.size.width / 6
        let spriteSize = 1.3 * unit
        
        sprite.size = CGSize(width: spriteSize, height: spriteSize)
        sprite.position = CGPoint(x: CGFloat(xPos * 2 + 1) * unit, y: unit * CGFloat(5 - 2 * yPos))
        addChild(sprite)
        symbols.append(sprite)
        
        if animated {
            lock(true)
            
            let animationAction = sprite.animation(atlasName: name, duration: 0.3)
            let unlock = SKAction.run { self.lock(false) }
            
            sprite.run(SKAction.sequence([animationAction, unlock]))
        } else {
            sprite.texture = sprite.lastTextureOfAnimation(forImageNamed: name)
        }
    }
    
    func clear() {
        
        _ = symbols.map { $0.removeFromParent() }
        symbols.removeAll()
        isLocked = false
    }
    
    func setImage() { texture = lastTextureOfAnimation(forImageNamed: Images.grid) }
    
    func animate() {
        
        lock(true)
        
        let animationAction = animation(atlasName: Images.grid, duration: 1.0)
        let unlock = SKAction.run { self.lock(false) }
        
        self.run(SKAction.sequence([animationAction, unlock]))
    }
    
    func add(victoryLine vl: VictoryLine, animated: Bool) {
        
        let name = Images.splatter
        
        let splatter = SKSpriteNode(imageNamed: "\(name)_001")
        let width = self.size.width
        let unit = width / 6
        let splatterTexture = splatter.lastTextureOfAnimation(forImageNamed: name)
        let proportion = splatterTexture.size().width / splatterTexture.size().height
        
        splatter.size = CGSize(width: 7 * unit * proportion, height: 7 * unit)
        var splatterPosition = CGPoint(x: width / 2, y: width / 2)

        switch vl {
        case .row(let line):
            splatter.zRotation = -CGFloat(Double.pi / 2)
            splatterPosition = CGPoint(x: width / 2, y: unit * CGFloat(5 - 2 * line))
        case .column(let line):
            splatterPosition = CGPoint(x: unit * CGFloat(2 * line + 1), y: width / 2)
        case .diagonal(let main):
            splatter.size = CGSize(width: 8 * unit * proportion, height: 8 * unit)
            splatter.zRotation = CGFloat(Double.pi / 4) * (main ? 1 : -1)
        }
        splatter.position = splatterPosition
        splatter.zPosition = zPosition + 2
        splatter.alpha = 0.9

        addChild(splatter)
        symbols.append(splatter)
        
        if animated {
            lock(true)
            
            let animationAction = splatter.animation(atlasName: name, duration: 0.3)
            let unlock = SKAction.run { self.lock(false) }
            
            splatter.run(SKAction.sequence([animationAction, unlock]))
        } else {
            splatter.texture = splatter.lastTextureOfAnimation(forImageNamed: name)
        }
    }
}
