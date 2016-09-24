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
    fileprivate let notificationCenter = NotificationCenter.default
    fileprivate let enterFore = NSNotification.Name.UIApplicationDidBecomeActive
    fileprivate let enterBack = NSNotification.Name.UIApplicationWillResignActive
    
    init() {
        registerForTypes()
        notificationCenter.addObserver(self, selector: #selector(enteringBackground), name: enterBack, object: nil)
        notificationCenter.addObserver(self, selector: #selector(enteringForeground), name: enterFore, object: nil)
    }
    
    func notifyDone(_ onDate: Date) {
        let notification = UILocalNotification()
        notification.alertBody = "Timer Done"
        notification.fireDate = onDate
        notification.soundName = AlertSound.getPreference().fileName()
        UIApplication.shared.scheduledLocalNotifications = [notification]
    }

    @objc func enteringForeground() {
        UIApplication.shared.scheduledLocalNotifications = []
    }
    
    @objc func enteringBackground() {
        guard let timerState = TimerStateArchiver.retrieveTimerState() else {
            return
        }
        let timeLeft = timerState.timerValue
        let timerDirection = timerState.direction
        let timerIsRunning = timerState.isRunning
        if ((timerDirection == .down) && (timeLeft > 0) && timerIsRunning) {
            NotificationController.instance.notifyDone(Date(timeIntervalSinceNow: timeLeft))
        }
    }
    
    fileprivate func registerForTypes() {
        let application = UIApplication.shared
        let notificationTypes = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(notificationTypes)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
}
