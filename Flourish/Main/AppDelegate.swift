//
//  AppDelegate.swift
//  Flourish
//
//  Created by Milos Otasevic on 08/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.appCoordinator.start()
        return true
    }

}
