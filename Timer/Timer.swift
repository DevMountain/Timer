//
//  Timer.swift
//  Timer
//
//  Created by Taylor Mott on 10/21/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

extension Notification.Name {
	static let secondTickNotification = Notification.Name("TimerSecondTickNotification")
	static let timerCompleteNotification = Notification.Name("TimerCompleteNotification")
}

class Timer: NSObject {
	
    fileprivate(set) var seconds = TimeInterval(0)
    fileprivate(set) var totalSeconds = TimeInterval(0)
    fileprivate var timer: Foundation.Timer?
    var isOn: Bool {
        get {
            if timer != nil {
                return true
            } else {
                return false
            }
        }
    }
    var string: String {
        get {
            let totalSeconds = Int(self.seconds)
            
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds - (hours * 3600)) / 60
            let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
            
            var hoursString = ""
            if hours > 0 {
                hoursString = "\(hours):"
            }
            
            var minutesString = ""
            if minutes < 10 {
                minutesString = "0\(minutes):"
            } else {
                minutesString = "\(minutes):"
            }
            
            var secondsString = ""
            if seconds < 10 {
                secondsString = "0\(seconds)"
            } else {
                secondsString = "\(seconds)"
            }
            
            return hoursString + minutesString + secondsString
        }
    }
    
    func setTimer(_ seconds: TimeInterval, totalSeconds: TimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
    }
    
    func startTimer() {
        if !isOn {
			timer = Foundation.Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(secondTick(_:)), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        if isOn {
            timer?.invalidate()
            timer = nil
        }
    }
	
	func secondTick(_ timer: Foundation.Timer) {
        seconds -= 1
        NotificationCenter.default.post(name: .secondTickNotification, object: self)
        if seconds <= 0 {
            stopTimer()
            NotificationCenter.default.post(name: .timerCompleteNotification, object: self)
        }
    }
}
