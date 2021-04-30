//
//  RecoveryPasswordInteractor.swift
//  Write
//
//  Created by Muhamed Niyazov on 19.04.2021.
//

import Foundation
import Firebase

protocol RecoveryPasswordBusinessLogic {
    func sendPasswordReset(_ request: RecoveryPasswordModels.SendEmail.Request)
}

protocol RecoveryPasswordDataStore {
    
}

final class RecoveryPasswordInteractor: RecoveryPasswordBusinessLogic, RecoveryPasswordDataStore {
    
    // MARK: - Public Properties
    var presenter: RecoveryPasswordPresentationLogic?
    
    // MARK: - Business Logic
    func sendPasswordReset(_ request: RecoveryPasswordModels.SendEmail.Request) {
        Auth.auth().sendPasswordReset(withEmail: request.email) { (error) in
            guard error == nil  else {
                self.presenter?.sendEmailError(.init(error: error!))
                return
            }
            
            self.presenter?.sendEmailSuccess()
        }
    }
    
}
