//
//  DocumentsInteractor.swift
//  Write
//
//  Created by Muhamed Niyazov on 22.04.2021.
//

import Foundation
import Firebase

protocol DocumentsBusinessLogic {
    func fetchDocuments()
}

protocol DocumentsDataStore {
    
}

final class DocumentsInteractor: DocumentsBusinessLogic, DocumentsDataStore {
    
    // MARK: -  Properties
    var presenter: DocumentsPresentationLogic?
    private let dataBase = Firestore.firestore()
    private let uid = Auth.auth().currentUser!.uid
    
    // MARK: - Business Logic
    func fetchDocuments() {
        let documentsRef = dataBase.collection("documents").whereField("uid", isEqualTo: uid)
            .order(by: "timestamp", descending: true)
        documentsRef.getDocuments() { (querySnapshot, err) in
            guard err == nil else { return  print("DEBUG: Error getting documents: \(String(describing: err!))") }

            self.presenter?.fetchDocumentsSucces(response: .init(data: querySnapshot!))
        }
    }
    
}
