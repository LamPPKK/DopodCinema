//
//  AppDelegate.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        // Turn off Dark mode
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }

        window?.rootViewController = HomeScreen()
        window?.makeKeyAndVisible()
        
        return true
    }
}

