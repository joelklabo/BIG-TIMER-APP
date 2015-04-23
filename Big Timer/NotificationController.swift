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
    
    class func notifyTimerDone () {
        NotificationController.notifyDone(NSDate())
    }
    
    class func notifyTimerDone(date: NSDate) {
        NotificationController.notifyDone(date)
    }
    
    class func notifyDone(onDate: NSDate) {
        var notification = UILocalNotification()
        notification.alertBody = "Timer Done"
        notification.fireDate = onDate
        UIApplication.sharedApplication().scheduledLocalNotifications = [notification]
    }
    
}