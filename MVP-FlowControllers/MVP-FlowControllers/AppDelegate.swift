//
//  AppDelegate.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupInitialScreen()
        return true
    }
    
}

extension AppDelegate {
    fileprivate func setupInitialScreen() {
        window = UIWindow(frame : UIScreen.main.bounds)
        FlowInizializer().configure(window)
    }
}

