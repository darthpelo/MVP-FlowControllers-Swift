//
//  DashboardPresenter.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardView: class {
    func updateUI(withTitleLabel titleText: String, withDescriptionLabel descriptionText: String, andButton title: String)
}

protocol DashboardPresenter {
    func setupUI()
}

class DashboardPresenterImplementation: DashboardPresenter {
    fileprivate weak var view: DashboardView?
    
    init(view: DashboardView?) {
        self.view = view
    }
    
    // MARK: - DashboardPresenter
    func setupUI() {
        view?.updateUI(withTitleLabel: "a", withDescriptionLabel: "aa", andButton: "next")
    }
}
