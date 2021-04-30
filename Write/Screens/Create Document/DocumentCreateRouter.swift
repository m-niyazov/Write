//
//  DocumentCreateRouter.swift
//  Write
//
//  Created by Muhamed Niyazov on 25.04.2021.
//

import UIKit

protocol DocumentCreateRoutingLogic {
    func navigateToMainScreen()
}

protocol DocumentCreateDataPassing {
  var dataStore: DocumentCreateDataStore? { get }
}

final class DocumentCreateRouter: DocumentCreateRoutingLogic, DocumentCreateDataPassing {

  // MARK: - Properties

  weak var parentController: UIViewController?
  weak var viewController: DocumentCreateViewController?
  var dataStore: DocumentCreateDataStore?
  

  // MARK: - Routing Logic
    func navigateToMainScreen() {
        viewController?.dismiss(animated: true, completion: nil)
    }

  // MARK: - Navigation
  

  // MARK: - Passing data
}
