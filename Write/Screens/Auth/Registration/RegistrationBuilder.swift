//
//  RegistrationBuilder.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

protocol RegistrationBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> RegistrationViewController
}

final class RegistrationBuilder: RegistrationBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> RegistrationViewController {
    let viewController = RegistrationViewController()
    
    let interactor = RegistrationInteractor()
    let presenter = RegistrationPresenter()
    let router = RegistrationRouter()

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
