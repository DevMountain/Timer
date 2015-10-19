//
//  AlarmViewController.swift
//  Timer
//
//  Updated by Taylor Mott on 10/16/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    

    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let alarm = Alarm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = NSDate()
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchToAlarmNotSetView", name: Alarm.kAlarmCompleteNotification, object: nil)
        
        guard let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        alarm.cancel()
        
        for notification in scheduledNotifications {
            if notification.category == Alarm.kAlarmAlert {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                
                guard let fireDate = notification.fireDate else { return }
                alarm.arm(fireDate)
                switchToAlarmSetView()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func alarmButtonTapped(sender: AnyObject) {
        if alarm.isArmed {
            alarm.cancel()
            switchToAlarmNotSetView()
        } else {
            let hasAskedPermissions = NSUserDefaults.standardUserDefaults().boolForKey(AppDelegate.kHasAskedPermissions)
            
            if !hasAskedPermissions {
                
                let prePermissionAlert = UIAlertController(title: "Notification Permissions", message: "We need your permission to notify you when your alarm is done. You can change this permission any time in your settings.", preferredStyle: .Alert)
                prePermissionAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (_) in
                    UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: AppDelegate.kHasAskedPermissions)
                    self.armAlarm()
                }))
                prePermissionAlert.addAction(UIAlertAction(title: "Maybe later", style: .Cancel, handler: { (_) in
                    
                    let alarmNotSetAlert = UIAlertController(title: "Alarm Not Set", message: "Your alarm is not set. Please enable notification permissions.", preferredStyle: .Alert)
                    
                    alarmNotSetAlert.addAction(UIAlertAction(title: "Don't set alarm", style: .Cancel, handler: nil))
                    alarmNotSetAlert.addAction(UIAlertAction(title: "Enable permission", style: .Default, handler: { (_) in
                        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: AppDelegate.kHasAskedPermissions)
                        self.armAlarm()
                    }))
                    
                    self.navigationController?.presentViewController(alarmNotSetAlert, animated: true, completion: nil)
                }))
                
                self.navigationController?.presentViewController(prePermissionAlert, animated: true, completion: nil)
                
            } else {
                self.armAlarm()
            }

        }
}
    
    func armAlarm() {
        alarm.arm(datePicker.date)
        switchToAlarmSetView()
    }
    
    func switchToAlarmSetView() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = .LongStyle
        
        messageLabel.text = "Your alarm is set!"
        
        if let date = alarm.alarmDate {
            dateLabel.text = dateFormatter.stringFromDate(date)
            datePicker.date = date
        } else {
            dateLabel.text = ""
        }
        
        alarmButton.setTitle("Cancel Alarm", forState: .Normal)
        datePicker.userInteractionEnabled = false
    }
    
    func switchToAlarmNotSetView() {
        alarm.cancel()
        messageLabel.text = "Your alarm is not set."
        dateLabel.text = ""
        alarmButton.setTitle("Set Alarm", forState: .Normal)
        datePicker.minimumDate = NSDate()
        datePicker.date = NSDate()
        datePicker.userInteractionEnabled = true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
