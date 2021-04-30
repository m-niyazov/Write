//
//  LoginBuilder.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

protocol LoginBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> LoginViewController
}

final class LoginBuilder: LoginBuildingLogic {
  
  // MARK: - Public Methods
  func makeScene(parent: UIViewController? = nil) -> LoginViewController {
    let viewController = LoginViewController()
    
    let interactor = LoginInteractor()
    let presenter = LoginPresenter()
    let router = LoginRouter()

    interactor.presenter = presenter
    presenter.viewController = viewController
    
    router.parentController = parent
    router.viewController = viewController
    router.dataStore = interactor

    viewController.interactor = interactor
    viewController.router = router
    
    return viewController
  }
}
