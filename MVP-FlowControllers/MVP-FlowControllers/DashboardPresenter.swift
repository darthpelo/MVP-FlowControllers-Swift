//
//  DashboardPresenter.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit

class DashboardPresenter: DashboardPresentable {
    fileprivate weak var view: DashboardView?
    
    init(view: DashboardView?) {
        self.view = view
    }
    
    // MARK: - DashboardPresenter
    func setupUI() {
        view?.updateUI(withTitleLabel: "Dashboard",
                       withDescriptionLabel: "First ViewController",
                       andButton: "Next")
    }
}
