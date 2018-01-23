//
//  PlayerEntity.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 09/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import Foundation

protocol PlayerEntity {
    
    var symbol: String { get set }
    var playDelegate: PlayDelegate? { get set }
    var number: Int { get set }
    func play(grid: [[String]])
}
