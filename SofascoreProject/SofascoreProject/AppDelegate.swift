//
//  AppDelegate.swift
//  SofascoreProject
//
//  Created by Sven Leko on 05.03.2024..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = EventsViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

