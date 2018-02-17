//
//  OptionsUtil.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 15/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

enum TypeOfButton {
    case back_to_menu, back_to_game, set_sound
}

class OptionsUtil: NSObject {
    
    var view: SKView?
    var type: TypeOfButton
    
    init(type: TypeOfButton, view: SKView? = nil) {
        
        self.type = type
        self.view = view
        super.init()
    }
    
    func backToMenu() {
        
        let sceneInstance = MenuScene(size: view!.bounds.size)
        let transition = SKTransition.fade(with: .white, duration: 1.0)
        view!.presentScene(sceneInstance, transition: transition)
    }
    
    func backToGame() {
        
        let sceneInstance = MenuScene(size: view!.bounds.size)
        let transition = SKTransition.fade(with: .white, duration: 1.0)
        view!.presentScene(sceneInstance, transition: transition)
    }
    
    func setSound() {
        
        let isSoundOn = defaultsStandard.soundOn()
        defaultsStandard.set(!isSoundOn, forKey: Defaults.soundOn)
    }
}

extension OptionsUtil: ButtonAction {
    
    func execute() {
        
        switch type {
        case .back_to_game:
            backToGame()
        case .back_to_menu:
            backToMenu()
        default:
            setSound()
        }
    }
}
