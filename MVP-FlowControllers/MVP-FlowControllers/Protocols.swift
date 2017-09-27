//
//  Protocols.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 24/09/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation

// MARK: Dashboard
protocol DashboardView: class {
    func updateUI(withTitleLabel titleText: String, withDescriptionLabel descriptionText: String, andButton title: String)
}

protocol DashboardPresentable {
    func setupUI()
}

protocol ConfigureDashboardViewControllerDelegate: class {
    func showNextViewController()
}

// MARK: Second View
protocol SecondView: class {
    func updateUI(withDescriptionLabel descriptionText: String)
}

protocol SecondPresentable {
    func setupUI()
}

protocol ConfigureSecondViewControllerDelegate: class {
    func showSecret()
}

// MARK: Secret View
protocol SecretView: class {
    func updateUI(withDescriptionLabel descriptionText: String)
}

protocol SecretPresenter {
    func setupUI()
}

protocol FlowControllerDelegate: class {
    func backToDashboard()
}

typealias FlowControllable = ConfigureSecondViewControllerDelegate & FlowControllerDelegate
