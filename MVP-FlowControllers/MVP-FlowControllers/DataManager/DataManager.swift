//
//  DataManager.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 22/09/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation

protocol DataManager {
    func getData(completition:@escaping (Any?) -> Void)
}

struct DataManagerImplementation: DataManager {
    func getData(completition: @escaping (Any?) -> Void) {
        completition(["object": "MVP Test"])
    }
}
