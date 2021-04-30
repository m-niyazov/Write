//
//  LoginRouter.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

protocol LoginRoutingLogic {
    func navigateToMainScreen()
    func navigateToRegistrationScreen()
    func navigateToRecoveryPasswordScreen()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    // MARK: - Properties
    weak var parentController: UIViewController?
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: - Routing Logic
    func navigateToMainScreen() {
        viewController?.navigationController?.pushViewController(MainTabController(), animated: true)
    }
    
    func navigateToRegistrationScreen() {
        let registrationScreen = RegistrationBuilder().makeScene()
        viewController?.navigationController?.pushViewController(registrationScreen, animated: true)
    }
    
    func navigateToRecoveryPasswordScreen() {
        let recoveryPasswordScreen = UINavigationController(rootViewController: RecoveryPasswordBuilder().makeScene())
        
        viewController?.present(recoveryPasswordScreen, animated: true, completion: nil)
    }
    
}
