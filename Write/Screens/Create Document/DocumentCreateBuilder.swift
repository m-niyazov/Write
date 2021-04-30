//
//  DocumentCreateBuilder.swift
//  Write
//
//  Created by Muhamed Niyazov on 25.04.2021.
//

import UIKit

protocol DocumentCreateBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> DocumentCreateViewController
}

final class DocumentCreateBuilder: DocumentCreateBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> DocumentCreateViewController {
    let viewController = DocumentCreateViewController()
    
    let interactor = DocumentCreateInteractor()
    let presenter = DocumentCreatePresenter()
    let router = DocumentCreateRouter()

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
