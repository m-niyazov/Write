//
//  DocumentService.swift
//  Write
//
//  Created by Muhamed Niyazov on 08.04.2021.
//

import Foundation
import Firebase

class DocumentService {
    static let instance = DocumentService()
    private let dataBase = Firestore.firestore()
    private let uid = Auth.auth().currentUser!.uid
    private init() {}
    
    func deleteDocument(documentId: String, completion: @escaping(() -> Void) ) {
        
        dataBase.collection("documents").document(documentId).delete() { err in
            if let err = err {
                print("DEBUG: Error removing document: \(err)")
            } else {
                completion()
            }
        }

    }
    
    func createDocument(data: [String: String], completion: @escaping(() -> Void)) {
        let newDocument = dataBase.collection("documents").document()
        
        newDocument.setData([
            "title": data["title"]!,
            "mainText": data["mainText"] ?? "",
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "uid": uid
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                completion()
            }
        }
    }
    
    func updateDocument(documentId: String, data: [String: String], completion: @escaping(() -> Void)) {

        
        let newDocument = dataBase.collection("documents").document(documentId)
        
        newDocument.updateData([
            "title": data["title"]!,
            "mainText": data["mainText"] ?? "",
            "uid": uid
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                completion()
            }
        }
    }
    
    func fetchDocuments(completion: @escaping([Document]) -> Void) {
        
        let documentsRef = dataBase.collection("documents").whereField("uid", isEqualTo: uid)
                                                           .order(by: "timestamp", descending: true)
        var documents = [Document]()
        documentsRef.getDocuments() { (querySnapshot, err) in
            guard err == nil else { return  print("DEBUG: Error getting documents: \(String(describing: err))") }
            for item in querySnapshot!.documents {
                let document = Document(documentId: item.documentID, dictionary: item.data())
                documents.append(document)
            }
           completion(documents)
        }
    }
}

