//
//  Alarm.swift
//  Timer
//
//  Created by Taylor Mott on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
	static let alarmFiredNotification = Notification.Name("alarmFiredNotification")
}

class Alarm: NSObject {
    static let alarmCategory = "alarmCategory"
    
    fileprivate(set) var alarmDate: Date?
    var isArmed: Bool {
        get {
            if alarmDate != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    fileprivate var localNotification: UILocalNotification?
    
    func arm(_ fireDate: Date) {
        alarmDate = fireDate
        let alarmNotification = UILocalNotification()
        alarmNotification.fireDate = alarmDate
        alarmNotification.timeZone = TimeZone.autoupdatingCurrent
        alarmNotification.soundName = "sms-received3.caf"
        alarmNotification.alertBody = "Alarm Complete!"
        alarmNotification.category = Alarm.alarmCategory
        
        UIApplication.shared.scheduleLocalNotification(alarmNotification)
        localNotification = alarmNotification
    }
    
    func cancel() {
        
        if isArmed {
            alarmDate = nil
            if let localNotification = localNotification {
                UIApplication.shared.cancelLocalNotification(localNotification)
            }
        }
        
    }
    
    static func alarmComplete() {
		let nc = NotificationCenter.default
		nc.post(name: .alarmFiredNotification, object: self, userInfo: nil)
    }
    
    
}
