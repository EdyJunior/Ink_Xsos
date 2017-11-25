//
//  UserDefaults+Extensions.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 25/11/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func soundOn() -> Bool {
        return defaultsStandard.bool(forKey: Defaults.soundOn)
    }
    
    func animationsOn() -> Bool {
        return defaultsStandard.bool(forKey: Defaults.animationsOn)
    }
}
