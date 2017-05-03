//
//  AlarmViewController.swift
//  Timer
//
//  Updated by Taylor Mott on 10/16/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
		
		NotificationCenter.default.addObserver(self, selector: #selector(switchToAlarmNotSetView(_:)), name: .alarmFiredNotification, object: nil)
        
        guard let scheduledNotifications = UIApplication.shared.scheduledLocalNotifications else { return }
        alarm.cancel()
        
        for notification in scheduledNotifications {
            if notification.category == Alarm.alarmCategory {
                UIApplication.shared.cancelLocalNotification(notification)
                
                guard let fireDate = notification.fireDate else { return }
                alarm.arm(fireDate)
                switchToAlarmSetView()
            }
        }
    }
	
    @IBAction func alarmButtonTapped(_ sender: AnyObject) {
        if alarm.isArmed {
            alarm.cancel()
            switchToAlarmNotSetView(nil)
        } else {
            armAlarm()
        }
    }
	
	// MARK: Private
    
    private func armAlarm() {
        alarm.arm(datePicker.date)
        switchToAlarmSetView()
    }
    
	private func switchToAlarmSetView() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        
        messageLabel.text = "Your alarm is set!"
        
        if let date = alarm.alarmDate {
            dateLabel.text = dateFormatter.string(from: date)
            datePicker.date = date
        } else {
            dateLabel.text = ""
        }
        
        alarmButton.setTitle("Cancel Alarm", for: UIControlState())
        datePicker.isUserInteractionEnabled = false
    }
    
   private dynamic func switchToAlarmNotSetView(_ notification: Notification?) {
        alarm.cancel()
        messageLabel.text = "Your alarm is not set."
        dateLabel.text = ""
        alarmButton.setTitle("Set Alarm", for: UIControlState())
        datePicker.minimumDate = Date()
        datePicker.date = Date()
        datePicker.isUserInteractionEnabled = true
    }
	
	// MARK: Properties
	
	let alarm = Alarm()
	
	@IBOutlet weak var alarmButton: UIButton!
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
}
