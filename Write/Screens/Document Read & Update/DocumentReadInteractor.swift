//
//  DocumentReadInteractor.swift
//  Write
//
//  Created by Muhamed Niyazov on 27.04.2021.
//

import Foundation
import Firebase

protocol DocumentReadBusinessLogic {
    func getDocument()
    func deleteDocument()
    func updateDocument(request: DocumentReadModels.updateDocument.Request)
}

protocol DocumentReadDataStore {
    var document: Document! {get set}
    
}

final class DocumentReadInteractor: DocumentReadBusinessLogic, DocumentReadDataStore {
    var document: Document!
    
    // MARK: - Properties
    var presenter: DocumentReadPresentationLogic?
    private let dataBase = Firestore.firestore()
    private let uid = Auth.auth().currentUser!.uid
    
    
    // MARK: - Business Logic
    func getDocument() {
        let response = DocumentReadModels.getDocument.Response(document: document)
        presenter?.getDocumentSuccess(response: response)
    }
    
    func updateDocument(request: DocumentReadModels.updateDocument.Request) {
        let newData = textFormatting(text: request.sourceText)
        let newDocument = dataBase.collection("documents").document(document.documentId)
        
        newDocument.updateData([
            "title": newData["title"]!,
            "mainText": newData["mainText"] ?? "",
            "uid": uid
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.presenter?.updateDocumentSuccess()
            }
        }
        
    }
    
    func deleteDocument() {
        dataBase.collection("documents").document(document.documentId).delete() { err in
            if let err = err {
                print("DEBUG: Error removing document: \(err)")
            } else {
                self.presenter?.deleteDocumentSuccess()
            }
        }
    }
    
    //MARK: - Helpers
    func textFormatting(text: String) -> [String: String] {
        let originalText = text
        let lines = originalText.split(separator:"\n")
        let title = String(lines.first!)
        let mainText = originalText.replacingOccurrences(of: title, with: "")
        
        return ["title": title, "mainText": mainText]
    }
}
