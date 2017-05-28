//
//  SecondViewController.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var configure: ConfigureViewController!
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent == self.navigationController?.parent {
            configure.delegate?.backToFirstViewController()
        }
    }
}
