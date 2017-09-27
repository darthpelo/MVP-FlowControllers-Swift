//
//  SecondPresenter.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 04/06/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation

class SecondPresenter: SecondPresentable {
    private weak var view: SecondView?
    private let dataManager: DataManager
    
    init(view: SecondView?, dataManager: DataManager = DataManagerImplementation()) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - DashboardPresenter
    func setupUI() {
        getObject()
    }
    
    private func getObject() {
        dataManager.getData { [weak self] (result) in
            guard let result = result as? [String: String] else { return }
            guard let label = result["object"] else { return }
            
            self?.view?.updateUI( withDescriptionLabel: label)
        }
    }
}
