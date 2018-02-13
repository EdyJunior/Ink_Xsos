//
//  SKSpriteNode+Extensions.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 24/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    
    func numberOfFrames(forImageNamed name: String) -> Int {
        
        let textures = SKTextureAtlas(named: name)
        let numImages = textures.textureNames.count
        
        return numImages
    }
    
    func lastNameOfAnimation(forImageNamed name: String) -> String {
        
        let imageName = "\(name)_%0.3d"
        let numImages = numberOfFrames(forImageNamed: name)
        
        return String.init(format: imageName, numImages)
    }
    
    func lastTextureOfAnimation(forImageNamed name: String) -> SKTexture {
        return SKTexture(imageNamed: lastNameOfAnimation(forImageNamed: name))
    }
    
    func animation(atlasName: String, duration: Double, restore: Bool = false) -> SKAction {
        
        var frames = [SKTexture]()
        let numImages = numberOfFrames(forImageNamed: atlasName)
        let imageName = "\(atlasName)_%0.3d"
        
        for i in 1...numImages {
            let name = String.init(format: imageName, i)
            frames.append(SKTexture(imageNamed: name))
        }
        let ani = SKAction.animate(with: frames,
                                         timePerFrame: duration / Double(numImages),
                                         resize: false,
                                         restore: restore)
        return ani
    }
    
    func animationLoop(atlasName: String, duration: Double, restore: Bool = false) -> SKAction {
        
        let ani = animation(atlasName: atlasName, duration: duration, restore: restore)
        let forever = SKAction.repeatForever(ani)
        
        return forever
    }
}
