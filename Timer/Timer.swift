//
//  Timer.swift
//  Timer
//
//  Created by Taylor Mott on 10/21/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Timer: NSObject {
    
    static let notificationSecondTick = "TimerNotificationSecondTick"
    static let notificationComplete = "TimerNotificationComplete"
    
    private(set) var seconds = NSTimeInterval(0)
    private(set) var totalSeconds = NSTimeInterval(0)
    private var timer: NSTimer?
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
    
    func setTimer(seconds: NSTimeInterval, totalSeconds: NSTimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
    }
    
    func startTimer() {
        if !isOn {
            timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.0), target: self, selector: "secondTick", userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        if isOn {
            timer?.invalidate()
            timer = nil
        }
    }

    func secondTick() {
        seconds--
        NSNotificationCenter.defaultCenter().postNotificationName(Timer.notificationSecondTick, object: self)
        if seconds <= 0 {
            stopTimer()
            NSNotificationCenter.defaultCenter().postNotificationName(Timer.notificationComplete, object: self)
        }
    }
}