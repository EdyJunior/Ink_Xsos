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
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.18 : 0.15
        
        let texture = SKTexture(imageNamed: Images.Buttons.options)
        let proportion = texture.size().height / texture.size().width
        let buttonWidth = sceneSize.width * factor
        let buttonSize = CGSize(width: buttonWidth, height: buttonWidth * proportion)
        let buttonImage = SKSpriteNode(texture: texture, color: .clear, size: buttonSize)
        
        super.init(sprite: buttonImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
