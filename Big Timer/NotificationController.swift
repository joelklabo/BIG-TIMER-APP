//
//  NotificationController.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/15/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

class NotificationController {
    
    static let instance = NotificationController()
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    private let enterFore = UIApplicationWillEnterForegroundNotification
    private let enterBack = UIApplicationDidEnterBackgroundNotification
    
    init() {
        registerForTypes()
        notificationCenter.addObserver(self, selector: #selector(enteringBackground), name: enterBack, object: nil)
        notificationCenter.addObserver(self, selector: #selector(enteringForeground), name: enterFore, object: nil)
    }
    
    func notifyDone(onDate: NSDate) {
        let notification = UILocalNotification()
        notification.alertBody = "Timer Done"
        notification.fireDate = onDate
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduledLocalNotifications = [notification]
    }

    @objc func enteringForeground() {
        // Clear local notifications when entering foreground
        UIApplication.sharedApplication().scheduledLocalNotifications = []
    }
    
    @objc func enteringBackground() {
        let timerState = TimerStateArchiver.retrieveTimerState()
        let timeLeft = timerState!.timerValue
        let timerDirection = timerState!.direction
        let timerIsRunning = timerState!.isRunning as Bool
        if ((timerDirection == TimerDirection.Down) && (timeLeft > 0) && timerIsRunning) {
            NotificationController.instance.notifyDone(NSDate(timeIntervalSinceNow: timeLeft))
        }
    }
    
    private func registerForTypes() {
        let application = UIApplication.sharedApplication()
        let notificationTypes = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        application.registerUserNotificationSettings(notificationTypes)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
}