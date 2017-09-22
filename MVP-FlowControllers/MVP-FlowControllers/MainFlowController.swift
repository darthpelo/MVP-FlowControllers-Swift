//
//  MainFlowController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit

class MainFlowController: FlowController {
    let configure: FlowConfigure
    private var childFlow: FlowController?
    
    required init(configure: FlowConfigure) {
        self.configure = configure
    }
    
    deinit {
        childFlow = nil
    }
    
    func start() {
        let navigationController = UINavigationController()
        if let frame = configure.window?.bounds {
            navigationController.view.frame = frame
        }

        configure.window?.rootViewController = navigationController
        configure.window?.makeKeyAndVisible()
        
        let dashConf = FlowConfigure(window: nil, navigationController: navigationController, parent: self)
        childFlow = DashboardFlowController(configure: dashConf)
        childFlow?.start()
    }
}
