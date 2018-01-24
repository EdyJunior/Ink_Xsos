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
    
    func draw(symbolName name: String, xPos: Int, yPos: Int) {
        
        let sprite = SKSpriteNode(imageNamed: name)
        let unit = self.size.width / 6
        let spriteSize = 1.3 * unit
        sprite.size = CGSize(width: spriteSize, height: spriteSize)
        
        sprite.position = CGPoint(x: CGFloat(xPos * 2 + 1) * unit, y: unit * CGFloat(5 - 2 * yPos))
        addChild(sprite)
        symbols.append(sprite)
    }
    
    func clear() {
        
        _ = symbols.map { $0.removeFromParent() }
        symbols.removeAll()
        isLocked = false
    }
    
    func setImage() { texture = lastTextureOfAnimation(forImageNamed: Images.grid) }
    
    func animate() {
        
        lock(true)
        
        var frames = [SKTexture]()
        let numImages = numberOfFrames(forImageNamed: Images.grid)
        let imageName = "\(Images.grid)_%0.3d"
        
        for i in 1...numImages {
            let name = String.init(format: imageName, i)
            frames.append(SKTexture(imageNamed: name))
        }
        let animation = SKAction.animate(with: frames,
                                         timePerFrame: 1.0 / Double(numImages),
                                         resize: false,
                                         restore: false)
        let wait = SKAction.wait(forDuration: 1.0)
        let unlock = SKAction.run { self.lock(false) }
        
        self.run(SKAction.sequence([animation, wait, unlock]))
    }
}
