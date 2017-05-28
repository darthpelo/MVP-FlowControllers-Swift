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
        window = UIWindow(frame : UIScreen.main.bounds)
        let configure = FlowConfigure(window: window, navigationController: nil, parent: nil)
        let mainFlow = MainFlowController(configure: configure)
        mainFlow.start()
        return true
    }

}

