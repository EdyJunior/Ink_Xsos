//
//  ClassicScene2.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 26/01/2018.
//  Copyright © 2018 Edvaldo Junior. All rights reserved.
//

import SpriteKit

protocol GridUpdater {
    
    func updateGrid(symb: String, row: Int, column col: Int)
    func lockGrid(_ flag: Bool)
}

protocol MatchPresentationManager {
    
    func show(winner: PlayerEntity, victoryLine vl: VictoryLine)
    func showDraw()
    func passTurn()
}

class ClassicScene: GameScene {
    
    var playerNumber = 1;
    var classic = ClassicGame()
    var hasAI: Bool!
    var nodesOfOptions = [SKNode]()
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        backgroundColor = .white
        
        if defaultsStandard.soundOn() {
            scene!.run (
                SKAction.playSoundFileNamed(Sounds.start, waitForCompletion: false)
            )
        }
        resetGame()
        
        let optionsButton = OptionsButton(sceneSize: self.scene!.size)
        optionsButton.position = CGPoint(x: scene!.size.width * 0.13, y: scene!.size.height * 0.93)
        optionsButton.action = self
        addChild(optionsButton)
    }
    
    func resetGame() {
        
        for e in endGameSprites { e.removeFromParent() }
        endGameSprites.removeAll()
        
        classic = ClassicGame()
        var player1, player2: PlayerEntity
        if hasAI {
            let random = arc4random_uniform(2)
            if random == 0 {
                player1 = ClassicPlayer(symbol: "X", number: 0, brush: .black, delegate: classic)
                player2 = ClassicAI(symbol: "O", number: 1, brush: .black, delegate: classic)
            } else {
                player1 = ClassicAI(symbol: "X", number: 0, brush: .black, delegate: classic)
                player2 = ClassicPlayer(symbol: "O", number: 1, brush: .black, delegate: classic)
            }
        } else {
            player1 = ClassicPlayer(symbol: "X", number: 0, brush: .black, delegate: classic)
            player2 = ClassicPlayer(symbol: "O", number: 1, brush: .black, delegate: classic)
        }
        classic.players = [player1, player2]
        classic.gridUpdater = self
        classic.matchManager = self
        grid.gridProtocol = classic
        
        playerNumber = 1
        modeLabel.text = "classic"
        messageLabel.text = "It’s X turn!"
        grid.clear()
        grid.lock(false)
        finishedEndAnimation = false
        matchNumber += 1
        
        if matchNumber > 1 { classic.passTurn() }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if classic.winner > -1 && finishedEndAnimation {
            resetGame()
        }
    }
    
    override func endGame() {
        
        super.endGame()
        messageLabel.text = "\(classic.currentPlayer.symbol) wins!"
        addResetLabel(interval: 2.7)
    }
    
    func addResetLabel(interval: Double = 0.7) {
        
        let sceneFrame = scene!.frame
        let resetLabel = SKLabelNode(fontNamed: Fonts.ink)
        resetLabel.fontSize = sceneFrame.width * 0.1
        resetLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.1)
        resetLabel.fontColor = .red
        resetLabel.text = "tap to reset"
        resetLabel.alpha = 0
        
        self.endGameSprites.append(resetLabel)
        addChild(resetLabel)
        
        resetLabel.run(SKAction.fadeAlpha(to: 1.0, duration: interval))
    }
}

extension ClassicScene: GridUpdater {
    
    func updateGrid(symb: String, row: Int, column col: Int) {
        grid.draw(symbolName: symb, row: row, column: col, animated: defaultsStandard.animationsOn())
    }
    
    func lockGrid(_ flag: Bool) { self.grid.lock(flag) }
}

extension ClassicScene: MatchPresentationManager {
    
    func show(winner: PlayerEntity, victoryLine vl: VictoryLine) {
        
        grid.add(victoryLine: vl, animated: defaultsStandard.animationsOn())
        
        let wait = SKAction.wait(forDuration: 0.4)
        let endAction = SKAction.run { self.endGame() }
        let sequence1 = SKAction.sequence([wait, endAction])
        
        let interval = defaultsStandard.animationsOn() ? 2.7 : 0.7
        let waitEndAnimation = SKAction.wait(forDuration: interval)
        let unlock = SKAction.run { self.finishedEndAnimation = true }
        
        let sequence2 = SKAction.sequence([waitEndAnimation, unlock])
        
        run(SKAction.group([sequence1, sequence2]))
    }
    
    func showDraw() {
        
        addResetLabel()
        messageLabel.text = "Draw!"
        
        let wait = SKAction.wait(forDuration: 0.7)
        let unlock = SKAction.run { self.finishedEndAnimation = true }
        
        run(SKAction.sequence([wait, unlock]))
    }
    
    func passTurn() {
        
        messageLabel.text = "It's \(classic.currentPlayer.symbol) turn!"
        grid.lock(false)
    }
}

extension ClassicScene: ButtonAction {
    
    func execute() {
        
        let sceneFrame = scene!.frame
        
        let blank = SKSpriteNode(texture: SKTexture(imageNamed: "blank"), color: .clear, size: scene!.size)
        blank.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        blank.zPosition = 10
        blank.alpha = 0.9
        
        let splashTexture = SKTexture(imageNamed: Images.Spots.option_splash)
        let splashProportion = splashTexture.size().height / splashTexture.size().width
        let splashSize = CGSize(width: sceneFrame.width, height: sceneFrame.width * splashProportion)
        let splash = SKSpriteNode(texture: splashTexture, color: .clear, size: splashSize)
        splash.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height - splashSize.height / 2)
        splash.zPosition = blank.zPosition + 1
        
        let device = UIDevice.current.userInterfaceIdiom
        let factor: CGFloat = device == .phone ? 0.18 : 0.14
        
        let optionsLabel = SKLabelNode(text: "options")
        optionsLabel.fontSize = sceneFrame.width * factor
        optionsLabel.position = CGPoint(x: sceneFrame.midX, y: size.height * 0.915)
        optionsLabel.fontColor = .white
        optionsLabel.zPosition = splash.zPosition + 1
        optionsLabel.fontName = Fonts.ink
        
        let soundButtonTexture = SKTexture(imageNamed: "\(Images.Buttons.sound)_001")
        let soundButtonProportion = soundButtonTexture.size().height / soundButtonTexture.size().width
        let soundButtonWidth = sceneFrame.width * 0.55
        let soundButtonSize = CGSize(width: soundButtonWidth, height: soundButtonWidth * soundButtonProportion)
        let soundButtonSprite = SKSpriteNode(texture: soundButtonTexture, color: .clear, size: soundButtonSize)
        let soundButton = CustomButton(sprite: soundButtonSprite)
        soundButton.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.65)
        soundButton.zPosition = blank.zPosition + 1
        let optionSound = OptionsUtil(type: .set_sound, view: self.view!)
        soundButton.action = optionSound
        
        if defaultsStandard.bool(forKey: Defaults.soundOn) {
            let number = soundButtonSprite.numberOfFrames(forImageNamed: Images.Buttons.sound)
            let name = String.init(format: "\(Images.Buttons.sound)_%03d", number)
            soundButton.imageButton.texture = SKTexture(imageNamed: name)
        }
        soundButton.action = optionSound
        
        let back1ButtonTexture = SKTexture(imageNamed: Images.Buttons.backGame)
        let back1ButtonProportion = back1ButtonTexture.size().height / back1ButtonTexture.size().width
        let back1ButtonWidth = sceneFrame.width * 0.75
        let back1ButtonSize = CGSize(width: back1ButtonWidth, height: back1ButtonWidth * back1ButtonProportion)
        let back1ButtonSprite = SKSpriteNode(texture: back1ButtonTexture, color: .clear, size: back1ButtonSize)
        let back1Button = CustomButton(sprite: back1ButtonSprite)
        back1Button.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.4)
        let optionBack1 = OptionsUtil(type: .back_to_game, view: self.view!)
        back1Button.action = optionBack1
        back1Button.zPosition = blank.zPosition + 1
        
        let back1Label = SKLabelNode(text: "back to game")
        back1Label.fontSize = sceneFrame.width * factor * 0.45
        back1Label.position = CGPoint(x: 0, y: back1ButtonSize.height * -0.05)
        back1Label.fontColor = .white
        back1Label.zPosition = back1Button.zPosition + 1
        back1Label.fontName = Fonts.ink
        back1Button.touchableArea.addChild(back1Label)
        
        let back2ButtonTexture = SKTexture(imageNamed: Images.Buttons.backMenu)
        let back2ButtonProportion = back2ButtonTexture.size().height / back2ButtonTexture.size().width
        let back2ButtonWidth = sceneFrame.width * 0.75
        let back2ButtonSize = CGSize(width: back2ButtonWidth, height: back2ButtonWidth * back2ButtonProportion)
        let back2ButtonSprite = SKSpriteNode(texture: back2ButtonTexture, color: .clear, size: back2ButtonSize)
        let back2Button = CustomButton(sprite: back2ButtonSprite)
        back2Button.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height * 0.15)
        let optionBack2 = OptionsUtil(type: .back_to_menu, view: self.view!)
        back2Button.action = optionBack2
        back2Button.zPosition = blank.zPosition + 1
        
        let back2Label = SKLabelNode(text: "back to menu")
        back2Label.fontSize = sceneFrame.width * factor * 0.45
        back2Label.position = CGPoint(x: 0, y: back2ButtonSize.height * -0.1)
        back2Label.fontColor = .white
        back2Label.zPosition = back2Button.zPosition + 1
        back2Label.fontName = Fonts.ink
        back2Button.touchableArea.addChild(back2Label)
        
        addChild(blank)
        addChild(splash)
        addChild(optionsLabel)
        addChild(soundButton)
        addChild(back1Button)
        addChild(back2Button)
    }
}
