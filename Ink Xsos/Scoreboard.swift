
//
//  Scoreboard.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 21/02/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

class Scoreboard: SKNode {
    
    var scoreNode1 = SKLabelNode()
    var scoreNode2 = SKLabelNode()
    var score1 = 0, score2 = 0

    init(sceneFrame: CGRect, hasAi: Bool) {
        
        super.init()

        let p1Text = hasAi ? "you" : "X"
        let p2Text = hasAi ? "AI" : "O"

        let vs = SKLabelNode()
        let player1 = SKLabelNode()
        let player2 = SKLabelNode()
        
        buildFont(label: player1, text: p1Text, color: Colors.red, sceneFrame: sceneFrame)
        buildFont(label: player2, text: p2Text, color: Colors.green, sceneFrame: sceneFrame)
        buildFont(label: scoreNode1, text: "0", color: .black, sceneFrame: sceneFrame)
        buildFont(label: scoreNode2, text: "0", color: .black, sceneFrame: sceneFrame)
        buildFont(label: vs, text: "vs", color: Colors.blue, sceneFrame: sceneFrame)
        
        let yLine1 = -sceneFrame.height * 0.35
        let yLine2 = yLine1 * 1.3
        vs.position = CGPoint(x: 0, y: yLine1)
        player1.position = CGPoint(x: -sceneFrame.width * 0.22, y: yLine1)
        player2.position = CGPoint(x: sceneFrame.width * 0.22, y: yLine1)
        scoreNode1.position = CGPoint(x: -sceneFrame.width * 0.22, y: yLine2)
        scoreNode2.position = CGPoint(x: sceneFrame.width * 0.22, y: yLine2)

        addChild(player1)
        addChild(player2)
        addChild(scoreNode1)
        addChild(scoreNode2)
        addChild(vs)
    }
    
    func buildFont(label: SKLabelNode, text: String, color: UIColor, sceneFrame: CGRect) {
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.12 : 0.09
        
        label.fontName = Fonts.ink
        label.fontColor = color
        label.fontSize = sceneFrame.width * factor
        label.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateScore() {
        
        scoreNode1.text = "\(score1)"
        scoreNode2.text = "\(score2)"
    }
}
