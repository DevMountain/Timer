//
//  AppearanceController.swift
//  Timer
//
//  Created by Taylor Mott on 10/21/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import UIKit

enum Theme {
    
    static func configureAppearance() {
        
        //Set colors for entire app.
        UINavigationBar.appearance().barTintColor = UIColor.orangeTimerColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UITabBar.appearance().barTintColor = UIColor.blueTimerColor
        UITabBar.appearance().tintColor = UIColor.lightBlueTimerColor
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white], for: UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightBlueTimerColor], for: .selected)
        
    }
}
