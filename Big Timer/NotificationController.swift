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
    private let notificationCenter = NotificationCenter.default
    private let enterFore = UIApplication.willEnterForegroundNotification
    private let enterBack = UIApplication.didEnterBackgroundNotification
    
    init() {
        registerForTypes()
        notificationCenter.addObserver(self, selector: #selector(enteringBackground), name: enterBack, object: nil)
        notificationCenter.addObserver(self, selector: #selector(enteringForeground), name: enterFore, object: nil)
    }
    
    func notifyDone(_ date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Done"
        let soundName = UNNotificationSoundName(AlertSound.selectedPreference.fileName)
        content.sound = UNNotificationSound(named: soundName)
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "timer-done", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
    }

    @objc func enteringForeground() {
        // Clear local notifications when entering foreground
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    @objc func enteringBackground() {
        let timerState = TimerStateArchiver.retrieveTimerState()
        let timeLeft = timerState!.timerValue
        let timerDirection = timerState!.direction
        let timerIsRunning = timerState!.isRunning as Bool
        if ((timerDirection == TimerDirection.Down) && (timeLeft > 0) && timerIsRunning) {
            NotificationController.instance.notifyDone(Date(timeIntervalSinceNow: timeLeft))
        }
    }
    
    private func registerForTypes() {
        let options = UNAuthorizationOptions(arrayLiteral: [.alert, .sound])
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error registering for Notifications: \(error.localizedDescription)")
            }
        }
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
}
