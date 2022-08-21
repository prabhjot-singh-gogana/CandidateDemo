//
//  AppDelegate.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 20/8/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame:UIScreen.main.bounds)
        window!.rootViewController = UINavigationController(rootViewController: GiftListVC())
        window!.makeKeyAndVisible()
        return true
    }


}
