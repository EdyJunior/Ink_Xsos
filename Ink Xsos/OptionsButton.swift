//
//  OptionsButton.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 10/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class OptionsButton: CustomButton {

    init(scene: GameScene) {
        
        let texture = SKTexture(imageNamed: Images.Buttons.options)
        let proportion = texture.size().height / texture.size().width
        let sceneSize = scene.size
        let buttonSize = CGSize(width: sceneSize.width * 0.1,
                                height: sceneSize.width * 0.1 * proportion)
        let buttonImage = SKSpriteNode(texture: texture, color: .clear, size: buttonSize)
        
        super.init(sprite: buttonImage)
        
        let animationAction = self.imageButton.animationLoop(atlasName: Images.Buttons.options, duration: 1.0, restore: true)
        
        self.run(animationAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
