//
//  DashboardFlowController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation

class DashboardFlowController: FlowController {
    
    enum DashboardFlowState: Int {
        case first
        case second
    }
    
    fileprivate let configure: FlowConfigure
    fileprivate var state: DashboardFlowState
    
    required init(configure: FlowConfigure) {
        self.configure = configure
        self.state = .first
    }
    
    func start() {
        switch self.state {
        case .first:
            guard let viewController = configureFirst() else { return }
            
            configure.navigationController?.pushViewController(viewController, animated: true)
        default: ()
        }
    }
    
    private func configureFirst() -> ViewController? {
        guard let viewController = R.storyboard.main.firstViewController() else { return nil }
        let presenter = DashboardPresenterImplementation(view: viewController)
        viewController.presenter = presenter
        viewController.configure = ConfigureViewController(delegate: self)
        return viewController
    }
}

extension DashboardFlowController: ConfigureViewControllerDelegate {
    func showNextViewController() {
        guard let viewController = R.storyboard.main.secondViewController() else { return }
        state = .second
        viewController.configure = ConfigureViewController(delegate: self)
        configure.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func backToFirstViewController() {
        state = .first
    }
}
