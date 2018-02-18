//
//  OptionsUtil.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 15/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

enum TypeOfButton {
    case back_to_menu, hide_options, set_sound
}

protocol HideOptionsDelegate {
    func hide()
}

class OptionsUtil: NSObject {
    
    var view: SKView?
    var type: TypeOfButton
    var hideDelegate: HideOptionsDelegate?
    
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
    
    func hideOptions() {
        
        hideDelegate!.hide()
//        for element in uiElements! { element.removeFromParent() }
//        uiElements!.removeAll()
    }
    
    func setSound() {
        
        let isSoundOn = defaultsStandard.soundOn()
        defaultsStandard.set(!isSoundOn, forKey: Defaults.soundOn)
    }
}

extension OptionsUtil: ButtonAction {
    
    func execute() {
        
        switch type {
        case .hide_options:
            hideOptions()
        case .back_to_menu:
            backToMenu()
        default:
            setSound()
        }
    }
}
