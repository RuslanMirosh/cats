//
//  AppDelegate.swift
//  Cats
//
//  Created by Руслан on 25.10.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var catsViewController: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        catsViewController = CatsViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = catsViewController
        window?.makeKeyAndVisible()
        return true
    }
    
    
}

