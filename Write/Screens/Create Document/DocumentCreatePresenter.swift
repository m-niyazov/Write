//
//  DocumentCreatePresenter.swift
//  Write
//
//  Created by Muhamed Niyazov on 25.04.2021.
//

import UIKit

protocol DocumentCreatePresentationLogic {
    func createDocumentSuccess()
}

final class DocumentCreatePresenter: DocumentCreatePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: DocumentCreateDisplayLogic?
    
    // MARK: - Presentation Logic
    func createDocumentSuccess() {
        viewController?.closeScreen()
    }
}
