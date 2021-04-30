//
//  SettingsBuilder.swift
//  Write
//
//  Created by Muhamed Niyazov on 30.04.2021.
//

import UIKit

protocol SettingsBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> SettingsViewController
}

final class SettingsBuilder: SettingsBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> SettingsViewController {
    let viewController = SettingsViewController()
    
    let interactor = SettingsInteractor()
    let presenter = SettingsPresenter()
    let router = SettingsRouter()

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
