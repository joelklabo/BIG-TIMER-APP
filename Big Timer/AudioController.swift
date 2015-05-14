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
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    init () {        
        var path = NSBundle.mainBundle().pathForResource("zarvox", ofType: "aiff")
        player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: nil)
        player.prepareToPlay()
    }
    
    func playSound () {
        player.play()
    }
}