//
//  RegistrationModels.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

enum RegistrationModels {
    
    // MARK: - Register
    enum Register {
        struct Request {
            let name: String
            let email: String
            let password: String
        }
        
        struct Response {
            let loginError: Error
        }
        
        struct ViewModel {
            let loginErrorText: String
        }
    }
}
