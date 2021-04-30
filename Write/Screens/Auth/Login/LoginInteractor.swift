//
//  LoginInteractor.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import Foundation
import Firebase

protocol LoginBusinessLogic {
    func logInUser(_ request: LoginModels.LoginWithEmail.Request)
}

protocol LoginDataStore {
    
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    // MARK: - Public Properties
    var presenter: LoginPresentationLogic?
    
    // MARK: - Business Logic
    func logInUser(_ request: LoginModels.LoginWithEmail.Request)  {
        Auth.auth().signIn(withEmail: request.email, password: request.password) { authResult, error in
            guard error == nil else {
                self.presenter?.logInUserError(.init(loginError: error!))
                return
            }
            
            self.presenter?.logInUserSucces()
        }
    }
}
