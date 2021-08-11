//
//  AppDelegate.swift
//  UalaLoans
//
//  Created by Ignacio on 08/27/2019.
//  Copyright (c) 2019 Ignacio. All rights reserved.
//

import UIKit
import UalaCore
import UalaUI
import UalaLoans

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        injectDependencies()
        customizeNavigationBar()
        window?.rootViewController = UalaNavigationController(rootViewController: ExampleViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    private func injectDependencies() {
        // dependencies
        CoreStarter.start(environment: EnvironmentBuilder.create(Scheme(rawValue: "stage")!))
        UIStarter.start(from: window!)
    }
    
    private func customizeNavigationBar() {
        
        UINavigationBar.appearance().tintColor = .lightishBlue
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.navigationBarText,
            .font: UIFont.regular(size: 17)
        ]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}

class UalaAnalytics: Analytics {
    func trackUser(name: String) { }
    func trackEvent(_ event: Event) {}
    func trackScreen(_ event: Event) { }
    func trackRevenue(_ revenue: Revenue) { }
}
