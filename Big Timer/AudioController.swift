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
    
    private var player: AVAudioPlayer = AVAudioPlayer()
    
    init () {        
        preparePlayerWith(alertSound: AlertSound.selectedPreference)
    }
    
    func playSound () {
        player.play()
    }
    
    func updateSound(sound: AlertSound) {
        preparePlayerWith(alertSound: sound)
    }
    
    private func preparePlayerWith(alertSound: AlertSound) {
        let path = Bundle.main.path(forResource: alertSound.rawValue, ofType: "aiff")
        do {
            player = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: path!) as URL)
        } catch _ {
        }
        player.prepareToPlay()
    }
    
}
