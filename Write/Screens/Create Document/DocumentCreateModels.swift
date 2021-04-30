//
//  DocumentCreateModels.swift
//  Write
//
//  Created by Muhamed Niyazov on 25.04.2021.
//

import UIKit

enum DocumentCreateModels {
    
    // MARK: - Models
    struct Credentials {
        let title: String
        let mainText: String?
    }
    // MARK: - View Models
    
    // Usecases
    enum createDocument {
        struct Request {
            let text: String
        }
        
        struct Response {
        
        }
        
        struct ViewModel {
            
        }
    }
}
