//
//  Button.swift
//  Ecos
//
//  Created by Edvaldo Junior on 07/10/16.
//  Copyright © 2016 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Button: SKNode {

    var defaultButton: SKSpriteNode
    var activeButton:  SKSpriteNode
    var touchableArea: SKSpriteNode

    var action: ((_ button: Button) -> Void)?

    var enabled: Bool = true
    var pressed: Bool {

        didSet {
            activeButton.isHidden = !pressed
            defaultButton.isHidden = pressed
        }
    }
    
    var size: CGSize {
        
        didSet {
            self.touchableArea.size = size
            self.defaultButton.size = size
            self.activeButton.size = size
        }
    }
    
    init(buttonAction: ((_ button: Button) -> Void)? = nil) {
        
        defaultButton = SKSpriteNode()
        activeButton = SKSpriteNode()
        touchableArea = SKSpriteNode()
        activeButton.isHidden = true
        action = buttonAction
        pressed = false
        size = defaultButton.size
        
        super.init()
        
        isUserInteractionEnabled = true
        
        touchableArea.addChild(defaultButton)
        touchableArea.addChild(activeButton)
        self.addChild(touchableArea)
    }
    
    init(defaultButtonSprite: SKSpriteNode, activeButtonSprite: SKSpriteNode, buttonAction: ((_ button: Button) -> Void)? = nil) {
        
        defaultButton = defaultButtonSprite.copy() as! SKSpriteNode
        activeButton = activeButtonSprite.copy() as! SKSpriteNode
        touchableArea = SKSpriteNode(color: .clear, size: defaultButton.size)
        action = buttonAction
        pressed = false
        size = defaultButtonSprite.size
        activeButton.isHidden = true
        
        super.init()
        
        isUserInteractionEnabled = true
        
        touchableArea.addChild(defaultButton)
        touchableArea.addChild(activeButton)
        self.addChild(touchableArea)
    }
    
    convenience init(sprite: SKSpriteNode, action: ((_ button: Button) -> Void)? = nil) {
        
        self.init(defaultButtonSprite: sprite, activeButtonSprite: sprite, buttonAction: action)
    }
    
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction: ((_ button: Button) -> Void)? = nil) {
        
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        touchableArea = SKSpriteNode()
        activeButton.isHidden = true
        action = buttonAction
        pressed = false
        size = defaultButton.size
        
        super.init()
        
        isUserInteractionEnabled = true
        
        touchableArea.addChild(defaultButton)
        touchableArea.addChild(activeButton)
        self.addChild(touchableArea)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touchableArea.contains((touches.first?.location(in: self))!) {
            if action != nil && enabled {
                pressed = !pressed
                action!(self)
            }
        }
    }
    
    func animate(_ AtlasName: String, imgName: String) {
        
        let textures = SKTextureAtlas(named: AtlasName)
        var frames = [SKTexture]()
        
        let numImages = textures.textureNames.count
        for i in 0..<numImages {
            let TextureName = "\(imgName)\(i)"
            frames.append(textures.textureNamed(TextureName))
        }
        let action = (SKAction.repeatForever(
            SKAction.animate(with: frames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)
            )
        )
        activeButton.run(action)
    }
    /*
    func setSizeAndPosition(_ size: CGSize, position: CGPoint, areaFactor factor: CGFloat) {
        
        defaultButton.size = size
        activeButton.size = size
        
        touchableArea = SKSpriteNode()
        touchableArea.size = CGSize(width: size.width * factor, height: size.height * factor)
        touchableArea.position = position
        
        touchableArea.addChild(defaultButton)
        touchableArea.addChild(activeButton)
        addChild(touchableArea)
    }
    */
}
