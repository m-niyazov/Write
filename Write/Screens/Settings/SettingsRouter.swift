//
//  SettingsRouter.swift
//  Write
//
//  Created by Muhamed Niyazov on 30.04.2021.
//

import UIKit

protocol SettingsRoutingLogic {
  func navigateToLoginScreen()
}

protocol SettingsDataPassing {
  var dataStore: SettingsDataStore? { get }
}

final class SettingsRouter: SettingsRoutingLogic, SettingsDataPassing {

  // MARK: -  Properties
  weak var parentController: UIViewController?
  weak var viewController: SettingsViewController?
  var dataStore: SettingsDataStore?

  // MARK: - Navigation
    func navigateToLoginScreen() {
        let loginScreen = LoginBuilder().makeScene()
        let navLoginScreen = UINavigationController(rootViewController: loginScreen)
        navLoginScreen.modalPresentationStyle = .fullScreen
        
        viewController?.present(navLoginScreen, animated: true, completion: nil)
    }
}
