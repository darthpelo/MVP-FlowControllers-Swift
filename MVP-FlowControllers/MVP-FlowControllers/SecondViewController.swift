//
//  SecondViewController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit

struct ConfigureSecondViewController {
    var flowController: FlowControllable? 
}

class SecondViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var presenter: SecondPresentable?
    var configure: ConfigureSecondViewController?
    
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
    
    @IBAction func secretButtonTapped(_ sender: Any) {
        configure?.flowController?.showSecret()
    }
}

extension SecondViewController: SecondView {
    func updateUI(withDescriptionLabel descriptionText: String) {
        DispatchQueue.main.async {
            self.label.text = descriptionText
        }
    }
}
