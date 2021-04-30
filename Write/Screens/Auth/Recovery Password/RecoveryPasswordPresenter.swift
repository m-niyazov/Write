//
//  RecoveryPasswordPresenter.swift
//  Write
//
//  Created by Muhamed Niyazov on 19.04.2021.
//

import UIKit

protocol RecoveryPasswordPresentationLogic {
    func sendEmailSuccess()
    func sendEmailError(_ response: RecoveryPasswordModels.SendEmail.Response)
}

final class RecoveryPasswordPresenter: RecoveryPasswordPresentationLogic {
    // MARK: - Public Properties
    weak var viewController: RecoveryPasswordDisplayLogic?
    
    // MARK: - Presentation Logic
    func sendEmailSuccess() {
        viewController?.showSuccessAlert()
    }
    
    func sendEmailError(_ response: RecoveryPasswordModels.SendEmail.Response) {
        viewController?.showErrorAlert(.init(error: response.error.localizedDescription))
    }
}
