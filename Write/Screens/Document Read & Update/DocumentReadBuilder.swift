//
//  DocumentReadBuilder.swift
//  Write
//
//  Created by Muhamed Niyazov on 27.04.2021.
//

import UIKit

protocol DocumentReadBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> DocumentReadViewController
}

final class DocumentReadBuilder: DocumentReadBuildingLogic {
  
  // MARK: - Public Methods

  func makeScene(parent: UIViewController? = nil) -> DocumentReadViewController {
    let viewController = DocumentReadViewController()
    
    let interactor = DocumentReadInteractor()
    let presenter = DocumentReadPresenter()
    let router = DocumentReadRouter()

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
