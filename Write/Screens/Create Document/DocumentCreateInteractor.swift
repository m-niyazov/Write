//
//  DocumentCreateInteractor.swift
//  Write
//
//  Created by Muhamed Niyazov on 25.04.2021.
//

import Foundation
import Firebase

protocol DocumentCreateBusinessLogic {
    func createDocument(request: DocumentCreateModels.createDocument.Request)
}

protocol DocumentCreateDataStore {
    
}

final class DocumentCreateInteractor: DocumentCreateBusinessLogic, DocumentCreateDataStore {
    
    // MARK: - Properties
    var presenter: DocumentCreatePresentationLogic?
    private let dataBase = Firestore.firestore()
    private let uid = Auth.auth().currentUser!.uid
    // MARK: - Business Logic
    
    func createDocument(request: DocumentCreateModels.createDocument.Request) {
        let credentials = textFormatting(text: request.text)
        
        let newDocument = dataBase.collection("documents").document()
        newDocument.setData([
            "title": credentials.title,
            "mainText": credentials.mainText ?? "",
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "uid": uid
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.presenter?.createDocumentSuccess()
            }
        }
    }
    
    func textFormatting(text: String) -> DocumentCreateModels.Credentials {
        let originalText = text
        let lines = originalText.split(separator:"\n")
        let title = String(lines.first!)
        let mainText = originalText.replacingOccurrences(of: title, with: "")
        
        return DocumentCreateModels.Credentials(title: title, mainText: mainText)
    }
}
