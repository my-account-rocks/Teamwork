//
//  AppDelegate.swift
//  Teamwork
//
//  Created by Pedro on 8/11/18.
//  Copyright © 2018 Pedro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = assembler().provideProjectsNavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}
