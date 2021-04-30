//
//  RegistrationRouter.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

protocol RegistrationRoutingLogic {
    func  navigateToLoginScreen()
    func  navigateToMainScreen()
}

protocol RegistrationDataPassing {
    var dataStore: RegistrationDataStore? { get }
}

final class RegistrationRouter: RegistrationRoutingLogic, RegistrationDataPassing {
    
    // MARK: - Public Properties
    weak var parentController: UIViewController?
    weak var viewController: RegistrationViewController?
    var dataStore: RegistrationDataStore?
    
    // MARK: - Routing Logic
    func navigateToLoginScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToMainScreen() {
        viewController?.navigationController?.pushViewController(MainTabController(), animated: true)
    }
    
}
