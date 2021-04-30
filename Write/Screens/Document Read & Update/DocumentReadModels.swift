//
//  DocumentReadModels.swift
//  Write
//
//  Created by Muhamed Niyazov on 27.04.2021.
//

import UIKit

enum DocumentReadModels {
    
    // MARK: - Models
    
    // MARK: - View Models
    //    struct DocumentRead {
    //        var title: String
    //        var mainText: String
    //        var timestamp: String
    //        var сompleteText: NSMutableAttributedString
    //        var documentId: String
    //    }
    
    // MARK: - UseCases
    enum getDocument {
        struct Request {
            
        }
        struct Response {
            var document: Document
        }
        
        struct ViewModel {
            var сompleteText: NSMutableAttributedString 
        }
    }
    
    enum updateDocument {
        struct Request {
            let sourceText: String
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
}
