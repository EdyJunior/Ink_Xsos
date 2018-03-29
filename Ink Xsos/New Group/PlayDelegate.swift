//
//  PlayDelegate.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 25/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import Foundation

@objc protocol PlayDelegate {
    
    var grid: [[String]] { get set }
    
    @objc optional func move (row: Int, column: Int)
    
    @objc optional func move (row: Int, column: Int, symbol: String)
}
