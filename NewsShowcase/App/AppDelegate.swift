//
//  AppDelegate.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp(application, launchOptions: launchOptions)

        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }

        let rootVc = SourcesListRouter.makeWithNavigation()
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()

        return true
    }

}

// MARK: - Initializers

extension AppDelegate {
    func configureApp(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        AppConfig.configure()
    }
}
