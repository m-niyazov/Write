//
//  DocumentReadPresenter.swift
//  Write
//
//  Created by Muhamed Niyazov on 27.04.2021.
//

import UIKit

protocol DocumentReadPresentationLogic {
    func getDocumentSuccess(response: DocumentReadModels.getDocument.Response)
    func deleteDocumentSuccess()
    func updateDocumentSuccess()
}

final class DocumentReadPresenter: DocumentReadPresentationLogic {
    // MARK: - Properties
    weak var viewController: DocumentReadDisplayLogic?
    
    
    
    // MARK: - Presentation Logic
    func getDocumentSuccess(response: DocumentReadModels.getDocument.Response) {
        let completeText = completeText(title: response.document.title, mainText: response.document.mainText)
        
        let viewModel = DocumentReadModels.getDocument.ViewModel(сompleteText: completeText)
        
        viewController?.showDocument(viewModel: viewModel)
    }
    
    
    func updateDocumentSuccess() {
        viewController?.endEditingDocument()
    }
    
    func deleteDocumentSuccess() {
        viewController?.endDeletingDocument()
    }
    
    
    //MARK: - Data preparation
    func timestampFormatter(timestamp: Double) -> String {
        let timeInterval = timestamp
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    func completeText(title: String, mainText: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: """
            \(mainText)
            """, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
        
        let titleBold = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: "PlayfairDisplay-Bold", size: 22)!])
        
        attributedText.insert(titleBold, at: 0)
        return attributedText
    }
}
