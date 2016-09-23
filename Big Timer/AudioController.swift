//
//  AudioController.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/12/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import AVFoundation

class AudioController {
    
    static let instance = AudioController()
    
    fileprivate var player: AVAudioPlayer = AVAudioPlayer()
    
    init () {        
        preparePlayerWith(AlertSound.getPreference())
    }
    
    func playSound () {
        player.play()
    }
    
    func updateSound(_ sound: AlertSound) {
        preparePlayerWith(sound)
    }
    
    fileprivate func preparePlayerWith(_ alertSound: AlertSound) {
        let path = Bundle.main.path(forResource: alertSound.rawValue, ofType: "aiff")
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        } catch _ {
        }
        player.prepareToPlay()
    }
    
}
