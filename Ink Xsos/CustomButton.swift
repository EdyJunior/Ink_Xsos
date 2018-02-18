//
//  CustomButton.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 12/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

protocol ButtonAction { func execute() }

class CustomButton: SKNode {

    var imageButton: SKSpriteNode
    var touchableArea = SKSpriteNode()
    var enabled: Bool = true
    var pressed: Bool = false
    var action: ButtonAction?
    var noDelegateAction: (() -> Void)?
 
    init(sprite: SKSpriteNode) {
        
        self.imageButton = sprite
        self.touchableArea.size = sprite.size
        super.init()
        
        self.touchableArea.addChild(imageButton)
        self.addChild(touchableArea)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touchableArea.contains((touches.first?.location(in: self))!) {
            if enabled {
                pressed = !pressed
                if let Action = action {
                    Action.execute()
                } else { noDelegateAction!() }
            }
        }
    }
}
