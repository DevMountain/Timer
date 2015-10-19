# Timer

Students will build a timer/alarm app, similar to Apple's Clock app, using NSTimer, StackViews, UIAppearance, UITabBarController, UIPickerViews, UIButtons.

Students who complete this project independently are able to:

* Work with UITabBarControllers
* Work with UIStackViews (and very basic autolayout)
* Use NSTimer to schedule function calls
* Build a reuseable Timer class
* Use protocols to set up UIPickerViews
* Use UIPickerViews to get user input
* Use button to respond to user interaction
* Use NSNotifcations to respond to events
* Use UILocalNotifications to alert user of events
* Use UIAlertControllers to display alerts to user
* Use UIProgressViews to display progress
* Use CALayers, UIAppearance, and Storyboards to modify views' look
* Use computed variables
* Use helper methods
* Build an extensions of another classes


## --- Part 1 ---
## Guide

Note: Try to avoid looking at the hints until you get stuck or have attempted it on your own. Use the hints to check your progress.

### UI - Timer View

Build a view that allows the user to input a desired length of time and allows the user to start a timer. The timer should count down to zero. When the timer reaches zero, reset the views to allow the user to input and start another timer. Use UIStackViews to help with the layout. See the screenshots, app wireframe diagram, and run solution code to see the recommended layout.

1. Embed the TimerViewController in a UINavigationController. Embed the UINavigationController in a UITabBarController.
2. Using the screenshots, app wireframe diagram, and running the solution code to see the recommended layout, layout the views for the timer view. No need to add design and color at this point. You may have a warning from hiding the progess view initially.
	* HINT: Constraints you will need:
		* PickerViews should have equal width
		* TimerLabel leading, training, bottom to super view leading, trailing bottom
		* TimerLabel top to super view top + 2
		* PickerView leading, top, trailing, bottom to super view leading margin, top, trailing margin, bottom
		* PauseButton aspect ratio 1:1
		* StartButton aspect ratio 1:1
		* StartButton width = 100
		* StartButton, PauseButton equal width
		* ButtonStackView center x, top, bottom to super view center x, top, bottom
		* MainStackView leading, top, trailing, bottom to super view leading, top layout guide, trailing, bottom layout guide

3. Hook up the necessary views in storyboard to the TimerViewController file.
	* HINT: You should have 7 view related properties
	* HINT: The views you have are:
		* timerLabel
		* hourPickerView
		* minutePickerView
		* pauseButton
		* startButton
		* pickerStackView
		* progressView
4. Implement the delegate and datasource for the two UIPickerViews. One should display the hours 0-23 and the other the minutes 0-59.
	* HINT: Don't forget to link up the delegate and datasource of the picker views
5. Add actions to the buttons with empty implementation.

### UI - Alarm View

1. Add an another ViewController to storyboard and a file for AlarmViewController. Make sure the ViewController custom class is set to the AlarmViewController.
2. Add a label to the AlarmViewController that says "Alarm View Controller". This is just a placehold until the AlarmViewController is implemented tomorrow.
3. Embed AlarmViewController in a UINavigationController. Add the UINavigationController as a viewController on the UITabBarController.

### Implement Timer Class

1. Create a new cocoa touch class called Timer which subclasses NSObject.
2. Create static constant Strings for the TimerSecondTickNotification and TimerCompleteNotification.
3. Create properties for a timer.
	* HINT: 
		* ```private(set) var seconds = NSTimeInterval(0)```
		* ```private(set) var totalSeconds = NSTimerInterval(0)```
		* ```private var timer: NSTimer?```
		* ```var isOn: Bool``` (computed property, check whether the timer is nil or not, timer will only be nil when not running)
4. Create a func setTime(second: NSTimeInterval, totalSeconds: NSTimeInterval).
5. Create a func startTimer().
	* HINT: If the timer property is nil, this will create a scheduled NSTimer and assign it to the timer property. The NSTimer should call the secondTick selector.
6. Create a func stopTimer()
	* HINT: If the timer property is set, this will invalidate the timer and set the timer property equal to nil
7. Create a func secondTick()
	* HINT: If the timer property is set, this function should decrease the seconds remaining on the timer by 1 and post a secondTickNotification. If the seconds have reached 0, it should also post a timerCompleteNotification and call stopTimer().
8. Create a func timerString() -> String
	* HINT: This method should take the number of seconds remaining and create a string that the user would expect to see on a timer.

### Link up the timer UI with the Timer class

1. We have two different view states, one when the timer is set and one when the user needs to/can set a timer  (see screenshots). Create a function to modify the views for when the timer is set. Create a function to modify the views for when the timer is not set. These functions will be called within the startTimerButtonPressed. Implement the startTimerButtonTapped function.
	* HINT: this method should check whether the user is starting the timer or canceling the timer and the views should update appropriately (button titles, hiding/unhiding pickerStackView, timerLabel, progress view)
2. Observe the second tick notification. When the viewcontroller observes this notification, it should update it's views; create a function that will update the required view after each second.
3. Observe the timerCompleteNotification. The function this notification should call should reset the views to allow the user to start another timer.

### Use UIAppearance and CALayers to modify the view's look

1. Create a swift file called Colors.swift. Add an extention of UIColor and add five static methods that return custom colors for your app.
2. Add icons to the tab bar items.
	* HINT: [Icons 8](icons8.com) or [The Noun Project](thenounproject.com)
3. Use UIAppearance and an AppearanceController to customize the appearance through the entire app.
	* HINT: Don't forget to call the AppearanceControllers function in didFinishLaunchingWithOptions
4. Use CALayer properties to make the buttons circular and have a border. 
	* HINT: You will not need to import QuartzCore in swift
	* HINT: User view.layoutIfNeeded() to get frame sizes based on constraints

### Black Diamonds

* Implement pause feature

### Tests

## Contributions

Please refer to CONTRIBUTING.md.

## --- Part 2 ---
## Guide

Note: Try to avoid looking at the hints until you get stuck or have attempted it on your own. Use the hints to check your progress.

### Alarm Class

1. Create a new swift file and class called Alarm. Alarm should subclass NSObject.
2. Create static strings for the UILocalNotificaiton category Alarm is going to use and a string for the alarm complete NSNotfication.
3. Add properties to the alarm class. What do you think you might need?
	* HINT: 
		* ```private(set) var alarmDate: NSDate?```
    	* ```var isArmed: Bool``` (Computed Variable that checks if alarmDate is nil)
		* ```private var localNotification: UILocalNotification?``` (You may need to ```import UIKit```)
4. Add and implement a func arm(fireDate: NSDate). This will set the alarmDate property, schedule the UILocalNotification and set the localNotification property.
5. Add and implement a func cancel(). This will cancel the scheduled UILocalNotification with a category using the string created above and clear the value in alarmDate.
6. Add and implement a static func alarmComplete(). This will post the alarm complete notification.

### Local Notifications

1. In applicationDidBecomeActive, register for notifications (ask the user for permission to display notifications)
2. In applicationDidReceiveLocalNotification, set up a UIAlertController to be displayed when the alarm UILocalNotification is fired. Use the notifications category property to identify the type (Alarm v. Timer) of notifciation.
	* HINT: The AppDelegate has a window property. Look at the documentation for UIWindow and see if there is a way you can get a UIViewController so you can present the UIAlertController.
3. Still in applicationDidReceiveLocalNotification, call the Alarm function ```alarmComplete()```

### UI - Alarm View Controller

1. Remove the place holder labels from alarm view controller.
2. Using a stack view place the following views: UIDatePicker, UILabel, UILabel, UIButton. Link up the views in storyboard to the class file (properties for each) and an IBAction for the button (alarmButtonTapped).
3. Make it so the user can't set the datePicker to a time in the past.
	* HINT: "Did you check the documentation?"
4. Like our TimerViewController, we have two different view states, one when the alarm is set and one when the user needs to/can set an alarm  (see screenshots). Create a function to modify the views for when the alarm is set. Create a function to modify the views for when the alarm is not set. These functions will be called within the alarmButtonPressed.
5. When the alarm button is tapped (alarmButtonTapped), determine whether the alarm is set or not, and perform actions accordingly (update views, armAlarm, cancelAlarm, etc.)
6. Register for the alarm complete notification. The ViewController should "switch" the views so the user can input a new alarm.
7. When the user comes back to app after being away for a while, it would be nice to have the views display that an alarm is currently set and for when. In viewDidLoad, cancel any alarm that might be set. Next, get all secheduled notifications, use a loop to find any notification that has the category of alarm. If you find a notification, cancel it and the alarm and use the properties of UILocalNotification to set the (new) alarm and update the views.
	* HINT: "Did you look at the documentation?"


### UILocalNotifications for Timer

1. Implement UILocalNotifications for the timer class as well. Add a UILocalNotification property. When the timer gets set, also schedule a local notification. Use the userInfo property of local notification to store the total time the user set the timer for so the progress view can be updated appropriately when coming back after the application has become inactive.
    * HINT: Use directions for Alarm if you get stuck.

### Better placement of notification permission

1. Figure out a better place to ask the user for notification permission (see solution app running for an example)

### Black Diamonds

* Create an actionable notification to restart the timer directly from a timer notification

### Tests

## Contributions

Please refer to CONTRIBUTING.md.


## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.


## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.