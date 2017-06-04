//
//  FlowInizializer.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 04/06/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit

struct FlowInizializer {
    func configure(_ window: UIWindow?) {
        let configure = FlowConfigure(window: window, navigationController: nil, parent: nil)
        let mainFlow = MainFlowController(configure: configure)
        mainFlow.start()
    }
}
