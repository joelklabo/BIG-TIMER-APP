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
    
    private let notificationController = NotificationController.instance

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        QuickActionController.setupCustomActions()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch _ {
        }
        
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        return true
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
            QuickActionController.handleAction(shortcutItem)
    }

}