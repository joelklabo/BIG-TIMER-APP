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
    
    class func notifyDone(date: NSDate) {
        
        var notification = UILocalNotification()
        notification.alertBody = "Big Timer Done"
        notification.fireDate = date ?? NSDate()
        notification.timeZone = NSTimeZone.defaultTimeZone()
        UIApplication.sharedApplication().scheduledLocalNotifications = [notification]
    }
    
}