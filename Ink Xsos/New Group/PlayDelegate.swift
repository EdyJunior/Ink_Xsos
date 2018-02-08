//
//  PlayDelegate.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 25/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import Foundation

protocol PlayDelegate {
    
    var grid: [[String]] { get set }
    
    func move (row: Int, column: Int)    
}
