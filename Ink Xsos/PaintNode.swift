//
//  PaintNode.swift
//  Ink Xsos
//
//  Created by Vítor Chagas on 24/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class PaintNode: SKSpriteNode {

    private let maxSplashes: Int = 10
    private let spots: [SKSpriteNode]
    
    private var splashes: [SKSpriteNode]
    
    init(size: CGSize) {
        
        self.spots = []
        self.splashes = []
        
        super.init(texture: nil, color: .clear, size: size)
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func splash(atPosition position: CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touched paintNode")
    }
    
}
