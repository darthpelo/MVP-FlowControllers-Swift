//
//  ViewController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit

struct ConfigureViewController {
    weak var delegate: ConfigureViewControllerDelegate?
}

protocol ConfigureViewControllerDelegate: class {
    func showNextViewController()
    func backToFirstViewController()
}

class ViewController: UIViewController, DashboardView {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var presenter: DashboardPresenter!
    var configure: ConfigureViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.setupUI()
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        configure.delegate?.showNextViewController()
    }
    
    func updateUI(withTitleLabel titleText: String, withDescriptionLabel descriptionText: String, andButton title: String) {
        self.title = titleText
        descriptionLabel.text = descriptionText
        nextButton.setTitle(title, for: .normal)
    }
}
