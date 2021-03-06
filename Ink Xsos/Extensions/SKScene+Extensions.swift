//
//  SKScene+Extensions.swift
//  Ink Xsos
//
//  Created by Vítor Chagas on 18/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

extension SKScene {
    
    func switchToScene(_ scene: SKScene.Type, withTransition transition: SKTransition = .fade(with: .white, duration: 1.0)) {

        guard let view = self.view else { return }
        
        let sceneInstance = scene.init(size: view.bounds.size)
        view.presentScene(sceneInstance, transition: transition)
    }
}
