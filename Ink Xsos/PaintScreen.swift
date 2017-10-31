//
//  PaintScreen.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 31/10/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import SpriteKit

protocol PaintScreen {
    
    var maxSplashes: [Int] { get set }
    var splashes: [SKSpriteNode] { get set }
    
    func clearScreen ()
    func splash (position: CGPoint)
}
