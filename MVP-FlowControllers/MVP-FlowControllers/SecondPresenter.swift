//
//  SecondPresenter.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 04/06/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation

protocol SecondView: class {
    func updateUI(withDescriptionLabel descriptionText: String)
}

protocol SecondPresenter {
    func setupUI()
}

class SecondPresenterImplementation: SecondPresenter {
    fileprivate weak var view: SecondView?
    fileprivate let dataManager: DataManager
    
    init(view: SecondView?, dataManager: DataManager = DataManagerImplementation()) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - DashboardPresenter
    func setupUI() {
        getObject()
    }
    
    private func getObject() {
        dataManager.gerData { [weak self] (result) in
            guard let result = result as? [String: String] else { return }
            guard let label = result["object"] else { return }
            
            self?.view?.updateUI( withDescriptionLabel: label)
        }
    }
}

protocol DataManager {
    func gerData(completition:@escaping (Any?) -> Void)
}

struct DataManagerImplementation: DataManager {
    func gerData(completition: @escaping (Any?) -> Void) {
        completition(["object": "MVP Test"])
    }
}
