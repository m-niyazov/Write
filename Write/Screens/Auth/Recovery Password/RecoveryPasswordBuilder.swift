//
//  RecoveryPasswordBuilder.swift
//  Write
//
//  Created by Muhamed Niyazov on 19.04.2021.
//

import UIKit

protocol RecoveryPasswordBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> RecoveryPasswordViewController
}

final class RecoveryPasswordBuilder: RecoveryPasswordBuildingLogic {
  
  // MARK: - Public Methods
  func makeScene(parent: UIViewController? = nil) -> RecoveryPasswordViewController {
    let viewController = RecoveryPasswordViewController()
    
    let interactor = RecoveryPasswordInteractor()
    let presenter = RecoveryPasswordPresenter()
    let router = RecoveryPasswordRouter()

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
