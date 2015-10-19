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

1. Add a view controller to Main.storyboard. Create a TimerViewController class file. Set the custom class of the ViewController you added to TimerViewController.
2. Embed the TimerViewController in a UINavigationController. Embed the UINavigationController in a UITabBarController.
3. Set the TabBarController as the initial view controller.
4. Using the screenshots, app wireframe diagram, and running the solution code to see the recommended layout, layout the views for the timer view. No need to add design and color at this point. You may have a warning from hiding the progess view initially.
* HINT: Views you will need:
* UIStackView (Vertical) (Main Stack View)
* UIProgressView
* UIView (Top View)
* UILabel (timer label)
* UIStackView (Horizontal) (Picker Stack View)
* UIPicker (Hours Picker)
* UILabel (Hours Label)
* UIPicker (Minutes Picker)
* UILabel (Minutes Label)
* UIView (Middle View)
* UIStackView (Horizontal) (Button Stack View)
* UIButton (Pause/Resume Button)
* UIButton (Start/Cancel Button)
* UIView (Bottom View)
* HINT: Constraints you will need:
* Main Stack View
* Leading to Leading of Superview (not to margins)
* Trailing to Trailing of Superview (not to margins)
* Top to Top Layout Guide.Bottom of Superview
* Bottom to Bottom Layout Guide.Top of Superview
* Timer Label
* Leading to Leading of Top View (to margins)
* Trailing to Trailing of Top View (to margins)
* Top to Top of Top View
* Bottom to Bottom of Top View
* Picker Views
* Equal widths
* Picker Stack View
* Leading to Leading of Top View (to margins)
* Trailing to Trailing of Top View (to margins)
* Top to Top of Top View
* Bottom to Bottom of Top View
* Pause Button
* Aspect Ratio = 1:1
* Width = 100
* Start Button
* Aspect Ratio = 1:1
* Buttons
* Equal Width
* Button Stack View
* Top to Top of Middle View
* Bottom to Bottom of Middle View
* Center X to Center X of Middle View
* Aside: At this point you might be getting console warnings about conflicting constraints. This has to do with the stack view trying to fill it's entire space, but the buttons only want to be 100 points wide. 
-OR- the buttoms might be right next to each other and we want to give them some breathing room. Fix:
* On the button stack view set the spacing to 55
* On the button stack view set distribution to "Equal Centering"
* You may still have a red arrow next to TimerViewController on storyboard's document outline (the left side panel in storyboard). Click that arrow, next click the red dot next to Content Abiguity, click "Change Priority"
5. Hook up the necessary views in storyboard to the TimerViewController file.
* HINT: You should have 7 view related properties
* HINT: The views you have are:
* timerLabel
* hourPickerView
* minutePickerView
* pauseButton
* startButton
* pickerStackView
* progressView
6. Implement the delegate and datasource for the two UIPickerViews. One should display the hours 0-23 and the other the minutes 0-59.
* HINT: Don't forget to link up the delegate and datasource of the picker views
7. Add actions to the buttons with empty implementation.

### UI - Alarm View

1. Add an another ViewController to storyboard and a file for AlarmViewController. Make sure the ViewController custom class is set to the AlarmViewController.
2. Add a label to the AlarmViewController that says "Alarm View Controller". This is just a placehold until the AlarmViewController is implemented tomorrow.
3. Embed AlarmViewController in a UINavigationController. Add the UINavigationController as a viewController on the UITabBarController.

### Implement Timer Class

Check out the documentation for NSTimer. Basically (*ding*) NSTimer is a class that allows you to create timers. More generally, NSTimer is a class that allows you to schedule function calls. The specified function will call when the timer fires. You set when the timer fires. You can have the timer fire once and be done or fire repeatedly. Using ```scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:``` you can instantiate an NSTimer and schedule it. The time interval is of type NSTimeInterval. NSTimeInterval is a typedef for double. NSTimeInterval represents a number of seconds. The target is when the function you want called "lives". The selector is a string of the functions name. UserInfo is a dictionary where you can pass around information. Repeats is a Bool that represents whether the timer will fire once (false) or repeat until ```timer.invalidate()``` is called. 

1. Create a new Cocoa Touch Class called Timer which subclasses NSObject.
2. The timer is going to have two NSNotifications: one when the second ticks and one when the timer is complete. Create static constant Strings (to be used as the name/indentifier of the NSNotification) for each one.
3. Create properties for a timer.
* HINT: 
* ```private(set) var seconds = NSTimeInterval(0)```
* ```private(set) var totalSeconds = NSTimeInterval(0)```
* ```private var timer: NSTimer?```
* ```var isOn: Bool``` (computed property, check whether the timer is nil or not, timer will only be nil when not running)
* note: we are making the ```seconds``` and ```totalSeconds``` properites setter methods private. We are doing this because we want anybody using our timer class to set these properties through a method we write.
4. Create a function to set the timer. This should take in the seconds and the totalSeconds.
5. Create a function to start the timer. This should check if the timer is already on. If not, it should schedule an NSTimer.
6. Create a function to stop the timer. This method should cancel the NSTimer and set it to nil.
7. Create a function to run on each second tick. This function should be called use the NSTimer. Every time it is called it should decrement the seconds property and post a second tick NSNotification. It should also check if the timer is complete and, if so, post a timer complete NSNotification.
8. Create another computed property that will return the number of seconds remaining on the timer in a human readable timer format, e.g. "12:05".

### Link up the timer UI with the Timer class

1. Add a property to TimerViewController of your new timer class.
2. We have two different view states, one when the timer is set and one when the user needs to/can set a timer  (see screenshots). Create a function to modify the views for when the timer is set. Create a function to modify the views for when the timer is not set. These functions will be called within the startTimerButtonPressed.
3. Implement the startTimerButtonTapped function.
* HINT: this method should check whether the user is starting the timer or canceling the timer and the views (button titles, hiding/unhiding pickerStackView, timerLabel, progress view) should update appropriately using the functions you wrote above in 1.
4. Observe the second tick NSNotification. When the viewcontroller observes this notification, it should update it's views; create a function that will update the required view(s) after each second.
5. Observe the timer complete NSNotification. The function this notification should call should reset the views to allow the user to start another timer.

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

### Black Diamonds

* Add UILocalNotifications to the Timer
* Figure out a better place to ask the user for notification permission
* Create an actionable notification to restart the timer directly from a timer notification

### Tests

## Contributions

Please refer to CONTRIBUTING.md.


## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.


## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.