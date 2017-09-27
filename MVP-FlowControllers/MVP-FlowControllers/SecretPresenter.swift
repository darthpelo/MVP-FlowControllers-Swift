//
//  SecretPresenter.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 24/09/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation

struct SecretPresenterImplementation: SecretPresenter {
    private weak var view: SecretView?
    private let dataManager: DataManager
    
    init(view: SecretView?, dataManager: DataManager = DataManagerImplementation()) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func setupUI() {
        getObject { (text) in
            guard let text = text else { return }
            
            self.view?.updateUI(withDescriptionLabel: text)
        }
    }
    
    private func getObject(_ completition:@escaping (String?) -> Void) {
        dataManager.getData { (result) in
            guard let result = result as? [String: String] else { return }
            guard let label = result["object"] else { return }
            
            completition(label)
        }
    }
}
