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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        if(UIApplication.instancesRespondToSelector(#selector(UIApplication.registerUserNotificationSettings(_:)))) {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Alert], categories: nil))
        }
        
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch _ {
        }
        
        setupCustomQuickActions()
        
        return true
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
            NSNotificationCenter.defaultCenter().postNotificationName(shortcutItem.type, object: nil)

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let timerState = TimerStateArchive.retrieveTimerState()
        let timeLeft = timerState!.timerValue
        let timerDirection = timerState!.direction
        let timerIsRunning = timerState!.isRunning as Bool
        if ((timerDirection == TimerDirection.Down) && (timeLeft > 0) && timerIsRunning) {
            NotificationController.notifyDone(NSDate(timeIntervalSinceNow: timeLeft))
        }
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {
    
    func setupCustomQuickActions() {
        let shortcutItems = CustomTimerManager().getTimes().map {
            shortcutItemForTime($0)
        }
        UIApplication.sharedApplication().shortcutItems = shortcutItems
    }
    
    func shortcutItemForTime(time: String) -> UIApplicationShortcutItem {
        let shorcutIcon = UIApplicationShortcutIcon(type: .Time)
        return UIApplicationShortcutItem(type: "\(time)", localizedTitle: "\(time) minutes", localizedSubtitle: "Counting Down", icon: shorcutIcon, userInfo: nil)
    }
    
}

