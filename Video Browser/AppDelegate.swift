//
//  AppDelegate.swift
//  Video Browser
//
//  Created by mayc on 2020/4/20.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var allowOrentitaionRotation = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: HomePageViewController())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
                
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if allowOrentitaionRotation {
            return .allButUpsideDown
        }
        return .portrait
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
       if let paste = UIPasteboard.general.string, paste.contains(FYRuleType.home.rawValue) {
            
        }
    }


}

