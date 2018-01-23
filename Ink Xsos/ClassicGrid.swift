//
//  ClassicGrid.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 22/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

protocol TouchedGrid {
    func touchIn(sector: Int)
}

class ClassicGrid: SKSpriteNode {
    
    var touchedProtocol: TouchedGrid?
    
    init(touchedProtocol: TouchedGrid, size: CGSize) {
        
        let texture = SKTexture(imageNamed: Images.grid)
        super.init(texture: texture, color: UIColor.clear, size: size)
        self.touchedProtocol = touchedProtocol
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
