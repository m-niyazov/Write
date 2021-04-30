//
//  DocumentsPresenter.swift
//  Write
//
//  Created by Muhamed Niyazov on 22.04.2021.
//

import UIKit

protocol DocumentsPresentationLogic {
    func fetchDocumentsSucces(response: DocumentsModels.fetchDocuments.Response)
}

final class DocumentsPresenter: DocumentsPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: DocumentsDisplayLogic?
    
    
    // MARK: - Presentation Logic
     func fetchDocumentsSucces(response: DocumentsModels.fetchDocuments.Response) {
        var documents = [Document]()
        for item in response.data.documents {
            let document = Document(documentId: item.documentID, dictionary: item.data())
            documents.append(document)
        }
        
        if(documents.isEmpty) {
            viewController?.showEmptyDocumentsView(show: true)
            viewController?.showDocuments(viewModel:.init(documents: documents))
            return
        }
        viewController?.showEmptyDocumentsView(show: false)
        viewController?.showDocuments(viewModel:.init(documents: documents))
    }
}
