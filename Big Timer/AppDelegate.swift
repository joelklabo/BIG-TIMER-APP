//
//  AppDelegate.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
                        
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
