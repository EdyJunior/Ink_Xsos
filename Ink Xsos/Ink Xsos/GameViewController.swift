//
//  GameViewController.swift
//  Ink Xsos
//
//  Created by Edvaldo Junior on 30/10/17.
//  Copyright © 2017 Edvaldo Junior. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

protocol SoundController {
    
    var sound: AVAudioPlayer? { get set }
    
    func stopSound()
    func playSound()
}

class GameViewController: UIViewController {

    var sound: AVAudioPlayer?
    
    override func viewDidLoad() {
        
        let scene = MinimalistMenuScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .white
        scene.soundController = self
        
        if defaultsStandard.soundOn() { playMenuSound() }

        skView.presentScene(scene)
    }
    
    func playMenuSound() {
        
        let path = Bundle.main.path(forResource: "menuSound.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            sound = try AVAudioPlayer(contentsOf: url)
            sound?.numberOfLoops = -1
            sound?.play()
        } catch { print("menuSound.wav doesn't exist!") }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: SoundController {
    
    func stopSound() {

        if let sound = sound {
            sound.stop()
            sound.currentTime = 0
        }
    }
    
    func playSound() {
        
        if let sound = sound {
            if !sound.isPlaying {
                playMenuSound()
            }
        } else { playMenuSound() }
    }    
}
