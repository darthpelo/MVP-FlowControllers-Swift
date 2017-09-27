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
    case secret
}

class DashboardFlowController: FlowController {
    private let configure: FlowConfigure
    private var state: DashboardFlowState
    
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
        case .secret:
            guard let viewController = configureSecret() else { return }
            
            configure.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    // MARK: - Private
    private func configureFirst() -> UIViewController? {
        guard let viewController = R.storyboard.main.firstViewController() else { return nil }
        
        viewController.presenter = DashboardPresenter(view: viewController)
        viewController.configure = ConfigureDashboard(delegate: self)
        return viewController
    }
    
    private func configureSecond() -> UIViewController? {
        guard let viewController = R.storyboard.main.secondViewController() else { return nil }
        
        viewController.presenter = SecondPresenter(view: viewController)
        viewController.configure = ConfigureSecondViewController(flowController: self)
        return viewController
    }
    
    private func configureSecret() -> UIViewController? {
        guard let viewController = R.storyboard.main.secretViewController() else { return nil }
        
        viewController.presenter = SecretPresenterImplementation(view: viewController)
        viewController.configure = ConfigureSecretViewController(flowController: self)
        return viewController
    }
    
    private func goNext() {
        switch state {
        case .main:
            self.state = .detail
        case .detail, .secret:
            return
        }
    }
    
    private func goPrevious() {
        switch state {
        case .main:
            return
        case .detail, .secret:
            self.state = .main
        }
    }
    
    private func goToSecret() {
        self.state = .secret
    }
}

extension DashboardFlowController: ConfigureDashboardViewControllerDelegate {
    func showNextViewController() {
        goNext()
        
        start()
    }
}

extension DashboardFlowController: ConfigureSecondViewControllerDelegate {
    func showSecret() {
        configure.navigationController?.popToRootViewController(animated: false)
        goToSecret()
        start()
    }
}

extension DashboardFlowController: FlowControllerDelegate {
    func backToDashboard() {
        goPrevious()
    }
}
