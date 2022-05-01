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
    
    let uniqueIdentifier = UUID().uuidString
    
    init() {
        registerForTypes()
    }
    
    func notifyDone(_ date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Done"
        let soundName = UNNotificationSoundName(AlertSound.selectedPreference.fileName)
        content.sound = UNNotificationSound(named: soundName)
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: uniqueIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [uniqueIdentifier])
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
    }

    func queue(timerState: TimerState) {
        let timeLeft = timerState.timerValue
        let timerDirection = timerState.direction
        let timerIsRunning = timerState.isRunning
        if ((timerDirection == .Down) && (timeLeft > 0) && timerIsRunning) {
            notifyDone(Date(timeIntervalSinceNow: timeLeft))
        }
    }
    
    func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    private func registerForTypes() {
        
        // Don't pop up permission dialog in UI tests
        guard UIApplication.shared.isTesting == false else {
            return
        }
        
        let options = UNAuthorizationOptions(arrayLiteral: [.alert, .sound])
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error registering for Notifications: \(error.localizedDescription)")
            }
        }
    }
}
