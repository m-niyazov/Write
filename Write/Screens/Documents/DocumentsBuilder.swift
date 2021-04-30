//
//  DocumentsBuilder.swift
//  Write
//
//  Created by Muhamed Niyazov on 22.04.2021.
//

import UIKit

protocol DocumentsBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> DocumentsViewController
}

final class DocumentsBuilder: DocumentsBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> DocumentsViewController {
    let viewController = DocumentsViewController()
    
    let interactor = DocumentsInteractor()
    let presenter = DocumentsPresenter()
    let router = DocumentsRouter()

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
