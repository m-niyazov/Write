//
//  RegistrationPresenter.swift
//  Write
//
//  Created by Muhamed Niyazov on 18.04.2021.
//

import UIKit

protocol RegistrationPresentationLogic {
    func createUserError(_ response: RegistrationModels.Register.Response)
    func createUserSuccess()
}

final class RegistrationPresenter: RegistrationPresentationLogic {
    // MARK: - Public Properties
    weak var viewController: RegistrationDisplayLogic?
    
    
    // MARK: - Presentation Logic
    func createUserError(_ response: RegistrationModels.Register.Response) {
        viewController?.showErrorText(.init(loginErrorText: response.loginError.localizedDescription))
    }
    
    func createUserSuccess() {
        viewController?.goToMainScreen()
    }
    
}
