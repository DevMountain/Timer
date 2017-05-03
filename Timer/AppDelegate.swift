//
//  AppDelegate.swift
//  Timer
//
//  Updated by Taylor Mott on 10/16/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
		
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		Theme.configureAppearance()
		
		application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
		
		return true
	}
	
	func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
		
		if notification.category == Alarm.alarmCategory {
			let alarmAlert = UIAlertController(title: "Alarm!", message: nil, preferredStyle: .alert)
			alarmAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			
			window?.rootViewController?.present(alarmAlert, animated: true, completion: nil)
			Alarm.alarmComplete()
		}
	}
}

