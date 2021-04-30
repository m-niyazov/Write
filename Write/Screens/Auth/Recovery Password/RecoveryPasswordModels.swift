//
//  RecoveryPasswordModels.swift
//  Write
//
//  Created by Muhamed Niyazov on 19.04.2021.
//

import UIKit

enum RecoveryPasswordModels {
  
    // MARK: - SendEmail
    enum SendEmail {
      struct Request {
        let email: String
      }
        
      struct Response {
        let error: Error
      }
      
      struct ViewModel {
        let error: String
      }
    }
}
