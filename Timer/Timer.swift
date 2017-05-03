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
	
	func setTimer(_ secondsRemaining: TimeInterval, totalSeconds: TimeInterval) {
		self.secondsRemaining = secondsRemaining
		self.totalSeconds = totalSeconds
	}
	
	func start() {
		guard !isOn else { return }
		timer = Foundation.Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(secondTick(_:)), userInfo: nil, repeats: true)
	}
	
	func togglePause() {
		if isOn {
			stop()
		} else {
			start()
		}
	}
	
	func stop() {
		guard isOn else { return }
		timer = nil
	}
	
	// MARK: Private
	
	private dynamic func secondTick(_ timer: Foundation.Timer) {
		secondsRemaining -= 1
		NotificationCenter.default.post(name: .secondTickNotification, object: self)
		if secondsRemaining <= 0 {
			stop()
			NotificationCenter.default.post(name: .timerCompleteNotification, object: self)
		}
	}
	
	// MARK: Properties
	
	private(set) var secondsRemaining = TimeInterval(0)
	private(set) var totalSeconds = TimeInterval(0)
	private var timer: Foundation.Timer? {
		willSet {
			timer?.invalidate()
		}
	}
	
	var isOn: Bool { return timer != nil }
	
	var timeRemainingString: String {
		let totalSeconds = Int(secondsRemaining)
		
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
