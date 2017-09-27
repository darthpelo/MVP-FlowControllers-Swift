//
//  SecretViewController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 24/09/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit

struct ConfigureSecretViewController {
    var flowController: FlowControllerDelegate?
}

class SecretViewController: UIViewController, SecretView {
    @IBOutlet weak var label: UILabel!
    
    var presenter: SecretPresenter?
    var configure: ConfigureSecretViewController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dch_checkDeallocation()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent == self.navigationController?.parent {
            // Comunicate the navigation action (back) to the FlowController
            configure?.flowController?.backToDashboard()
        }
    }
    
    func updateUI(withDescriptionLabel descriptionText: String) {
        label.text = descriptionText
    }
}
