//
//  OptionsButton.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 10/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class OptionsButton: CustomButton {

    init(sceneSize: CGSize) {
        
        let texture = SKTexture(imageNamed: "\(Images.Buttons.options)_001")
        let proportion = texture.size().height / texture.size().width
        let buttonWidth = sceneSize.width * 0.18
        let buttonSize = CGSize(width: buttonWidth, height: buttonWidth * proportion)
        let buttonImage = SKSpriteNode(texture: texture, color: .clear, size: buttonSize)
        
        super.init(sprite: buttonImage)
        
        let animationAction = self.imageButton.animationBackLoop(atlasName: Images.Buttons.options, duration: 0.8)
        
        self.imageButton.run(animationAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
