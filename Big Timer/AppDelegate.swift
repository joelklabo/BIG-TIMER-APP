//
//  AppDelegate.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit
import AVFoundation
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let notificationController = NotificationController.instance

    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Update this when you move to scene delegate
        application.statusBarStyle = .darkContent
                
        QuickActionController.setupCustomActions()
        
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        MSAppCenter.start("dbc86395-287d-46fc-a2b4-18a668592f06", withServices:[
          MSAnalytics.self,
          MSCrashes.self
        ])
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        QuickActionController.handleAction(shortcutItem: shortcutItem)
    }
}
