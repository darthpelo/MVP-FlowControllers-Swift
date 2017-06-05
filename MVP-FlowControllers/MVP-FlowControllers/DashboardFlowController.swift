//
//  DashboardFlowController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit

enum DashboardFlowState: Int {
    case main
    case detail
}

class DashboardFlowController: FlowController {
    fileprivate let configure: FlowConfigure
    fileprivate var state: DashboardFlowState
    
    required init(configure: FlowConfigure) {
        self.configure = configure
        self.state = .main
    }
    
    func start() {
        switch self.state {
        case .main:
            guard let viewController = configureFirst() else { return }
            
            configure.navigationController?.pushViewController(viewController, animated: true)
        case .detail:
            guard let viewController = configureSecond() else { return }
            
            configure.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    fileprivate func configureFirst() -> UIViewController? {
        guard let viewController = R.storyboard.main.firstViewController() else { return nil }
        
        viewController.presenter = DashboardPresenterImplementation(view: viewController)
        viewController.configure = ConfigureDashboardViewController(delegate: self)
        return viewController
    }
    
    fileprivate func configureSecond() -> UIViewController? {
        guard let viewController = R.storyboard.main.secondViewController() else { return nil }
        
        viewController.presenter = SecondPresenterImplementation(view: viewController)
        viewController.configure = ConfigureSecondViewController(delegate: self)
        return viewController
    }
    
    fileprivate func goNext() {
        switch state {
        case .main:
            self.state = .detail
        case .detail:
            return
        }
    }
    
    fileprivate func goPrevious() {
        switch state {
        case .main:
            return
        case .detail:
            self.state = .main
        }
    }
}

extension DashboardFlowController: ConfigureDashboardViewControllerDelegate {
    func showNextViewController() {
        goNext()
        
        start()
    }
}

extension DashboardFlowController: ConfigureSecondViewControllerDelegate {
    func backToFirstViewController() {
        goPrevious()
    }
}
