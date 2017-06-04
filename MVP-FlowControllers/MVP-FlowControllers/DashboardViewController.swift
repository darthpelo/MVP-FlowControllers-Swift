//
//  DashboardViewController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit

struct ConfigureDashboardViewController {
    weak var delegate: ConfigureDashboardViewControllerDelegate?
}

protocol ConfigureDashboardViewControllerDelegate: class {
    func showNextViewController()
}

class DashboardViewController: UIViewController, DashboardView {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var presenter: DashboardPresenter!
    var configure: ConfigureDashboardViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.setupUI()
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        configure.delegate?.showNextViewController()
    }
    
    // MARK: - DashboardView protocol
    func updateUI(withTitleLabel titleText: String,
                  withDescriptionLabel descriptionText: String,
                  andButton title: String) {
        DispatchQueue.main.async {
            self.title = titleText
            self.descriptionLabel.text = descriptionText
            self.nextButton.setTitle(title, for: .normal)
        }
    }
}
