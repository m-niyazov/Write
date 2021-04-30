//
//  DocumentReadRouter.swift
//  Write
//
//  Created by Muhamed Niyazov on 27.04.2021.
//

import UIKit

protocol DocumentReadRoutingLogic {
    func navigateToMainScreen()
}

protocol DocumentReadDataPassing {
    var dataStore: DocumentReadDataStore? { get set}
}


final class DocumentReadRouter: DocumentReadRoutingLogic, DocumentReadDataPassing {
    
    // MARK: - Properties
    weak var parentController: UIViewController?
    weak var viewController: DocumentReadViewController?
    var dataStore: DocumentReadDataStore?
    
    
    // MARK: - Routing Logic
    func navigateToMainScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Passing data
    
    
}
