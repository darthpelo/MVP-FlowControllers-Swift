//
//  Extensions.swift
//  MVP-FlowControllers
//
//  Created by Alessio Roberto on 26/09/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func dch_checkDeallocation(afterDelay delay: TimeInterval = 2.0) {
        let rootParentViewController = dchRootParentViewController
        
        // We don’t check `isBeingDismissed` simply on this view controller because it’s common
        // to wrap a view controller in another view controller (e.g. in UINavigationController)
        // and present the wrapping view controller instead.
        if isMovingFromParentViewController || rootParentViewController.isBeingDismissed {
            let typef = type(of: self)
            let disappearanceSource: String = isMovingFromParentViewController ? "removed from its parent" : "dismissed"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: { [weak self] in
                assert(self == nil, "\(typef) not deallocated after being \(disappearanceSource)")
            })
        }
    }
    
    private var dchRootParentViewController: UIViewController {
        var root = self
        
        while let parent = root.parent {
            root = parent
        }
        
        return root
    }
}
