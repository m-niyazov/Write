//
//  RecoveryPasswordRouter.swift
//  Write
//
//  Created by Muhamed Niyazov on 19.04.2021.
//

import UIKit

protocol RecoveryPasswordRoutingLogic {
   func navigateToMainScreen()
}

protocol RecoveryPasswordDataPassing {
    var dataStore: RecoveryPasswordDataStore? { get }
}

final class RecoveryPasswordRouter: RecoveryPasswordRoutingLogic, RecoveryPasswordDataPassing {
    
    // MARK: - Public Properties
    weak var parentController: UIViewController?
    weak var viewController: RecoveryPasswordViewController?
    var dataStore: RecoveryPasswordDataStore?
    
    
    // MARK: - Routing Logic
    func navigateToMainScreen() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
