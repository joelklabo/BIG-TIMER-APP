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
        
    private var player: AVAudioPlayer = AVAudioPlayer()
    
    init () {        
        preparePlayerWith(AlertSound.getPreference())
    }
    
    init (alertSound: AlertSound) {
        preparePlayerWith(alertSound)
    }
    
    func playSound () {
        player.play()
    }
    
    private func preparePlayerWith(alertSound: AlertSound) {
        let path = NSBundle.mainBundle().pathForResource(alertSound.rawValue, ofType: "aiff")
        do {
            player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!))
        } catch _ {
        }
        player.prepareToPlay()
    }
    
}