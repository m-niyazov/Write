//
//  DocumentsModels.swift
//  Write
//
//  Created by Muhamed Niyazov on 22.04.2021.
//

import UIKit
import Firebase

enum DocumentsModels {
    // ViewModel
    struct CollectionViewCellViewModel {
        private var document: Document!
        var title: String {
            return document.title
        }
        var timestamp: String {
                let timeInterval = document.timestamp
                let date = NSDate(timeIntervalSince1970: timeInterval)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM, yyyy"
                let dateString = dateFormatter.string(from: date as Date)
                return dateString
            }
        
        init(document: Document) {
            self.document = document
        }
    }
    // MARK: - Usecases
    enum fetchDocuments {
        struct Request {}
        
        struct Response {
            var data: QuerySnapshot
        }
        
        struct ViewModel {
            var documents: [Document]
        }
    }
}
