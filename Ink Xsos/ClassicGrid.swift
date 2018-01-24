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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGSize) {
        
        let textures = SKTextureAtlas(named: Images.grid)
        let numImages = textures.textureNames.count
        let imageName = "\(Images.grid)_%0.3d"
        let texture = SKTexture(imageNamed: String.init(format: imageName, numImages))
        
        super.init(texture: texture, color: UIColor.clear, size: size)
        isUserInteractionEnabled = true
        anchorPoint = CGPoint.zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.count == 1 {
            let touch = touches.first!
            let pos = touch.location(in: self)

            let xRel = pos.x / size.width
            let yRel = pos.y / size.height
            var xPos = 0, yPos = 2
            var last = 1
            
            for i in [2, 3] {
                if xRel > CGFloat(last) / 3 && xRel <= CGFloat(i) / 3 { xPos = i - 1 }
                if yRel > CGFloat(last) / 3 && yRel <= CGFloat(i) / 3 { yPos = 3 - i }
                last = i
            }
            print("x = \(xPos); y = \(yPos)")
            self.touchedProtocol?.touchIn(xPos, yPos)
        } else {
            print("Multiple touches are not allowed")
        }
    }
}
