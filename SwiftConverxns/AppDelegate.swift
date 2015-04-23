//
//  AppDelegate.swift
//  SwiftConverxns
//
//  Created by Adam Cherochak on 4/8/15.
//  Copyright (c) 2015 Adam Cherochak. All rights reserved.
//  2015-04-20-1033 wk3 removed tabBarController references
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //wk3-3.f ensure location to store favorites
        if let data: NSData = NSUserDefaults.standardUserDefaults().objectForKey("FavoriteConversions") as? NSData {
        }
        else
        {
            let defaultFavorites = NSKeyedArchiver.archivedDataWithRootObject([])
            NSUserDefaults.standardUserDefaults().registerDefaults(["FavoriteConversions" : defaultFavorites])
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        // 2.f this is the Temperature Conversion View & tab item
        let temperatureConverterViewController = TemperatureConverterViewController (nibName: "TemperatureConverter", bundle: NSBundle.mainBundle())
        temperatureConverterViewController.title = "Temperature"
        let firstNavController = UINavigationController(rootViewController: temperatureConverterViewController)
        firstNavController.tabBarItem.title = "Temperature"
        
        
        // 2.f this is the Distance Conversion View & tab item
        let distanceConverterViewController = DistanceConverterViewController (nibName: "DistanceConverter", bundle: NSBundle.mainBundle())
        distanceConverterViewController.title = "Distance"
        let secondNavController = UINavigationController(rootViewController: distanceConverterViewController)
        secondNavController.tabBarItem.title = "Distance"
        
        
        // 2.f this is the Volumetric Conversion View & tab item
        let volumetricConverterViewController = VolumetricConverterViewController (nibName: "VolumetricConverter", bundle: NSBundle.mainBundle())
        volumetricConverterViewController.title = "Volumetric"
        let thirdNavController = UINavigationController(rootViewController: volumetricConverterViewController)
        thirdNavController.tabBarItem.title = "Volumetric"
        
        //wk3-5.0 add favorite menu item
        let favoritesViewController = FavoritesTableViewController(nibName: "FavoritesTableViewController", bundle: NSBundle.mainBundle())
        
//let tabBarController = UITabBarController()
//tabBarController.viewControllers = [firstNavController, secondNavController, thirdNavController]
        
        // 2.a
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

//self.window?.rootViewController = tabBarController
        //wk3-2i inititialize MenuViewController with array of view controllers
        let menuVC = MenuViewController(viewControllers: [temperatureConverterViewController, distanceConverterViewController, volumetricConverterViewController, favoritesViewController])
        
        menuVC.title = "Menu"
        
        let mainNavigationController = UINavigationController(rootViewController: menuVC)
        
        self.window?.rootViewController = mainNavigationController
        
        self.window?.addSubview(mainNavigationController.view)
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

