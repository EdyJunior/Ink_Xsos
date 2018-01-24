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
}
