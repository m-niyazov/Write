//
//  LoginPresenter.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

protocol LoginPresentationLogic {
    func logInUserError(_ response: LoginModels.LoginWithEmail.Response)
    func logInUserSucces()
}

final class LoginPresenter: LoginPresentationLogic {
    // MARK: - Public Properties
    weak var viewController: LoginDisplayLogic?
    
    // MARK: - Presentation Logic
    func logInUserError(_ response: LoginModels.LoginWithEmail.Response) {
        let errorText = response.loginError.localizedDescription
        viewController?.showErrorLabel(.init(loginErrorText: errorText))
    }
    
    func logInUserSucces() {
        viewController?.goToMainScreen()
    }
}
