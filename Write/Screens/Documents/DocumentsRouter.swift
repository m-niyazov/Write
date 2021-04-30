//
//  DocumentsRouter.swift
//  Write
//
//  Created by Muhamed Niyazov on 22.04.2021.
//

import UIKit

protocol DocumentsRoutingLogic {
    func navigateToCreateDocumentScreen()
    func navigateToSelectedDocument(selectedDocument: Document) 
}

protocol DocumentsDataPassing {
    var dataStore: DocumentsDataStore? { get }
}

final class DocumentsRouter: DocumentsRoutingLogic, DocumentsDataPassing {
    
    // MARK: - Properties
    
    weak var parentController: UIViewController?
    weak var viewController: DocumentsViewController?
    var dataStore: DocumentsDataStore?
    
    
    // MARK: - Routing Logic
    func navigateToCreateDocumentScreen() {
        let documentCreateScreen = DocumentCreateBuilder().makeScene()
        documentCreateScreen.delegate = viewController
        let navDocumentCreateScreen = UINavigationController(rootViewController: documentCreateScreen)
        
        viewController?.present(navDocumentCreateScreen, animated: true)
    }
    
    func navigateToSelectedDocument(selectedDocument: Document) {
        let documentRead = DocumentReadBuilder().makeScene()
        documentRead.router?.dataStore?.document = selectedDocument
        documentRead.delegate = viewController
        viewController?.navigationController?.pushViewController(documentRead, animated: true)
        
    }
}
