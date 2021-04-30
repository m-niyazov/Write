//
//  RegistrationInteractor.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import Foundation
import Firebase

protocol RegistrationBusinessLogic {
   func createUser(_ request: RegistrationModels.Register.Request) 
}

protocol RegistrationDataStore {
    
}

final class RegistrationInteractor: RegistrationBusinessLogic, RegistrationDataStore {
    // MARK: - Public Properties
    var presenter: RegistrationPresentationLogic?

    // MARK: - Business Logic
    func createUser(_ request: RegistrationModels.Register.Request) {
        
        Auth.auth().createUser(withEmail: request.email, password: request.password) { authResult, error in
            guard error == nil else {
                self.presenter?.createUserError(.init(loginError: error!))
                return
            }
            
            // Success create user
            let dataBase = Firestore.firestore()
            dataBase.collection("users").addDocument(data: ["name" : request.name, "uid" : authResult!.user.uid]) { error in
                guard error == nil else {
                    self.presenter?.createUserError(.init(loginError: error!))
                    return
                }
                // Success create and saving user data
                self.presenter?.createUserSuccess()
            }
        }
    }
}
