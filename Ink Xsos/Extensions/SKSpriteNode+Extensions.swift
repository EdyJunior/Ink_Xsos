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
    
    func getFrames(atlasName: String) -> [SKTexture] {
        
        var frames = [SKTexture]()
        let numImages = numberOfFrames(forImageNamed: atlasName)
        let imageName = "\(atlasName)_%0.3d"
        
        for i in 1...numImages {
            let name = String.init(format: imageName, i)
            frames.append(SKTexture(imageNamed: name))
        }
        return frames
    }
    
    func getFramesBackward(atlasName: String) -> [SKTexture] {
        
        var frames = [SKTexture]()
        let numImages = numberOfFrames(forImageNamed: atlasName)
        let imageName = "\(atlasName)_%0.3d"
        
        for i in stride(from: numImages, to: 0, by: -1) {
            let name = String.init(format: imageName, i)
            frames.append(SKTexture(imageNamed: name))
        }
        return frames
    }
    
    func animation(atlasName: String, duration: Double, backward: Bool = false) -> SKAction {
        
        var frames: [SKTexture]
        if backward { frames = getFramesBackward(atlasName: atlasName) }
        else { frames = getFrames(atlasName: atlasName) }
        let numImages = frames.count
        let ani = SKAction.animate(with: frames,
                                         timePerFrame: duration / Double(numImages),
                                         resize: false,
                                         restore: false)
        return ani
    }
    
    func animationLoop(atlasName: String, duration: Double) -> SKAction {
        
        let ani = animation(atlasName: atlasName, duration: duration)
        let forever = SKAction.repeatForever(ani)
        
        return forever
    }
    
    func animationBack(atlasName: String, duration: Double) -> SKAction {
        
        var frames = getFrames(atlasName: atlasName)
        let backwardFrames = getFramesBackward(atlasName: atlasName)
        let numImages = frames.count
        frames.remove(at: numImages - 1)
        frames.append(contentsOf: backwardFrames)
        let ani = SKAction.animate(with: frames,
                                   timePerFrame: duration / Double(numImages),
                                   resize: false,
                                   restore: false)
        return ani
    }
    
    func animationBackLoop(atlasName: String, duration: Double) -> SKAction {
        
        let ani = animationBack(atlasName: atlasName, duration: duration)
        let forever = SKAction.repeatForever(ani)
        
        return forever
    }
}
