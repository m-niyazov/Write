//
//  LoginModels.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

enum LoginModels {
    
    // MARK: - LoginWithEmail
    enum LoginWithEmail {
      struct Request {
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

