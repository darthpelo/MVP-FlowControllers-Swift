//
//  SecondViewController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit

struct ConfigureSecondViewController {
    weak var delegate: ConfigureSecondViewControllerDelegate?
}

protocol ConfigureSecondViewControllerDelegate: class {
    func backToFirstViewController()
}

class SecondViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var presenter: SecondPresenter!
    var configure: ConfigureSecondViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.setupUI()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent == self.navigationController?.parent {
            configure.delegate?.backToFirstViewController()
        }
    }
}

extension SecondViewController: SecondView {
    func updateUI(withDescriptionLabel descriptionText: String) {
        DispatchQueue.main.async {
            self.label.text = descriptionText
        }
    }
}
